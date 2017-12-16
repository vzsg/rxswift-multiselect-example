import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MultiSelectCell", bundle: nil),
                                forCellWithReuseIdentifier: "MultiSelectCell")

        let selectionObserver = PublishSubject<NewsCategory>()
        let selectionState: Driver<Set<NewsCategory>> = selectionObserver.asObservable()
            .scan(Set()) { (acc: Set<NewsCategory>, item: NewsCategory) in
                var acc = acc
                if acc.contains(item) {
                    acc.remove(item)
                } else {
                    acc.insert(item)
                }

                return acc
            }
            .startWith(Set())
            .asDriver(onErrorJustReturn: Set())

        let submit = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = submit

        selectionState.map { !$0.isEmpty }
            .drive(submit.rx.isEnabled)
            .disposed(by: disposeBag)

        submit.rx.tap
            .asDriver()
            .withLatestFrom(selectionState)
            .drive(onNext: { [weak self] state in
                guard let `self` = self else {
                    return
                }

                let message = state.map { $0.description }.joined(separator: "\n")
                let alert = UIAlertController(title: "You selected", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yay!", style: .default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        Driver.just(NewsCategory.all)
            .drive(collectionView.rx.items(cellIdentifier: "MultiSelectCell", cellType: MultiSelectCell.self)) { (_, item, cell) in
                cell.bind(to: selectionState, as: item, observer: selectionObserver.asObserver())
            }
            .disposed(by: disposeBag)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

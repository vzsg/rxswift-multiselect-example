import Foundation
import UIKit
import RxSwift
import RxCocoa

class MultiSelectCell: UICollectionViewCell {
    private var disposeBag = DisposeBag()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func bind<T>(to state: Driver<Set<T>>, as item: T, observer: AnyObserver<T>) {
        titleLabel.text = "\(item)"
        state.map { $0.contains(item) }
            .drive(selectButton.rx.isSelected)
            .disposed(by: disposeBag)

        selectButton.rx.tap
            .asDriver()
            .map { _ in item }
            .drive(observer)
            .disposed(by: disposeBag)
    }
}

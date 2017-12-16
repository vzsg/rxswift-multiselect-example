enum NewsCategory: String {
    case breakingNews
    case collegesAndUniversities
    case currentEvents
    case environmental
    case government
    case magazines
    case media
    case newspapers
    case politics
    case regionalNews
    case religionAndSpirituality
    case sports
    case technology
    case traffic
    case weather
    case weblogs

    static var all: [NewsCategory] {
        return [
            .breakingNews,
            .collegesAndUniversities,
            .currentEvents,
            .environmental,
            .government,
            .magazines,
            .media,
            .newspapers,
            .politics,
            .regionalNews,
            .religionAndSpirituality,
            .sports,
            .technology,
            .traffic,
            .weather,
            .weblogs
        ]
    }
}

extension NewsCategory: CustomStringConvertible {
    var description: String {
        switch self {
        case .breakingNews:
            return "Breaking News"
        case .collegesAndUniversities:
            return "Colleges and Universities"
        case .currentEvents:
            return "Current Events"
        case .environmental:
            return "Environmental"
        case .government:
            return "Government"
        case .magazines:
            return "Magazines"
        case .media:
            return "Media"
        case .newspapers:
            return "Newspapers"
        case .politics:
            return "Politics"
        case .regionalNews:
            return "Regional News"
        case .religionAndSpirituality:
            return "Religion and Spirituality"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        case .traffic:
            return "Traffic"
        case .weather:
            return "Weather"
        case .weblogs:
            return "Weblogs"
        }
    }
}

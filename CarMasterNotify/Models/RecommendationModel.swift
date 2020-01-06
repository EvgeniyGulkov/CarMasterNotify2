import Foundation

struct RecommendationModel: Detail, Codable {
    var text: String?
    var date: Date?
    var userName: String?
    var isMy: Bool?
    
    init(text: String, date: Date = Date(), userName: String = "", isMy: Bool = true) {
        self.text = text
        self.date = date
        self.userName = userName
        self.isMy = isMy
    }

    enum CodingKeys: String, CodingKey {
        case text = "message"
        case userName = "username"
        case date = "created"
        case isMy
    }
}

import Foundation

struct ReasonModel: Detail, Codable {
    var id:String?
    var orderNumber: Int?
    var text: String?
    var isComplete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case orderNumber = "orderNum"
        case text = "reasonText"
        case isComplete = "reasonStatus"
    }
}

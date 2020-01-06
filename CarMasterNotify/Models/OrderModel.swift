import Foundation

struct OrderSection: Codable {
    static let dateFormat = "dd.MM.yyyy"
    var date: Date
    var items: [OrderModel]
    
    init(order:OrderModel) {
        self.date = (order.date?.midnightDate())!
        self.items = [order]
    }
}

struct OrderModel: Codable {
    var orderNumber: Int?
    var date: Date?
    var plateNumber: String?
    var manufacturer: String?
    var model: String?
    var status: String?
    var vinNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case plateNumber = "plate"
        case orderNumber = "orderNum"
        case manufacturer = "manufacturer"
        case model = "model"
        case status = "status"
        case vinNumber = "vinNumber"
        case date
    }
}

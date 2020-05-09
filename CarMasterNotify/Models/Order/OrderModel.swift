import UIKit
import CoreData

struct OrderModel: Codable {
    
    var orderNumber: Int?
    var createDate: Date?
    var updateDate: Date?
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
        case createDate = "createDate"
        case updateDate = "updateDate"
    }
    
    func toManagedObject() -> Order {
        let context = CoreDataManager.context
        context?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let order = Order(context: context!)
        order.createDate = self.createDate
        order.updateDate = self.updateDate
        order.manufacturer = self.manufacturer
        order.model = self.model
        order.number = Int32(self.orderNumber!)
        order.plateNumber = self.plateNumber
        order.status = self.status
        order.vin = self.vinNumber
        return order
    }
}

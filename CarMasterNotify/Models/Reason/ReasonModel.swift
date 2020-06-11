import CoreData

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

    func toManagedObject(order: Order) -> Reason {
        let context = DataController.shared.main
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let reason = Reason(context: context)
        reason.id = self.id
        reason.text = self.text
        reason.order = order
        reason.status = self.isComplete!
        return reason
    }
}

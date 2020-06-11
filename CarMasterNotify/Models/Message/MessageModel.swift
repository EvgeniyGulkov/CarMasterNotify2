import CoreData

struct MessageModel: Detail, Codable {
    var text: String?
    var date: Date?
    var userName: String?
    var isMy: Bool?
    var id: String?

    init(id: String, text: String, date: Date = Date(), userName: String = "", isMy: Bool = true) {
        self.text = text
        self.date = date
        self.userName = userName
        self.isMy = isMy
        self.id = id
    }

    enum CodingKeys: String, CodingKey {
        case text = "message"
        case userName = "username"
        case date = "created"
        case isMy
        case id = "_id"
    }

    @discardableResult
    func toManagedObject(order: Order) -> Message {
        let context = DataController.shared.main
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let message = Message(context: context)
        message.id = self.id
        message.text = self.text
        message.created = Date()
        message.order = order
        message.username = self.userName
        message.isMy = self.isMy!
        return message
    }
}

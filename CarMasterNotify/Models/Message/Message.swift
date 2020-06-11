import RxSwift
import CoreData

private let context = DataController.shared.main
private let disposeBag = DisposeBag()
private let networkProvider =  CustomMoyaProvider<CarMasterApi>()

extension Message: Detail {

    static func messages(offset: Int = 0, limit: Int = 0, order: Order) -> [Message] {
        let request = NSFetchRequest<Message>(entityName: String(describing: self))
        request.fetchLimit = limit
        request.fetchOffset = offset
        request.predicate = NSPredicate(format: "order.number == %@", NSNumber(value: order.number))
        do {
            let orders = try context.fetch(request)
            return orders
        } catch {
            print(error)
            return []
        }
    }

    func toObject() -> MessageModel {
        let message = MessageModel(id: self.id!,
                                   text: self.text!,
                                   date: self.created!,
                                   userName: self.username!,
                                   isMy: self.isMy)
        return message
        }
}

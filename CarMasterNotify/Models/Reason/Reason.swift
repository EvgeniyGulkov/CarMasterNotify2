import Foundation
import CoreData
import RxSwift

private let context = DataController.shared.main
private let disposeBag = DisposeBag()
private let networkProvider =  CustomMoyaProvider<CarMasterApi>()

extension Reason: Detail {
    
    static func reasons(orderNumber: Int) -> [Reason] {
        let request = NSFetchRequest<Reason>(entityName: String(describing: self))
        request.predicate = NSPredicate(format: "order.number = %@", orderNumber)
        do {
            let orders = try context.fetch(request)
            return orders
        } catch {
            print(error)
            return []
        }
    }
    
    func toObject() -> ReasonModel {
        let reason = ReasonModel(id: id!,
                                 orderNumber: Int(order!.number),
                                 text: text,
                                 isComplete: status)
        return reason
        }
}

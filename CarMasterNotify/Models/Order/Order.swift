import UIKit
import CoreData
import RxSwift
import Moya

private let context = DataController.shared.main
private let disposeBag = DisposeBag()

struct OrderSection {
    static let dateFormat = "dd.MM.yyyy"
    var date: Date
    var items: [Order]
    
    init(order:Order) {
        self.date = (order.updateDate?.midnightDate())!
        self.items = [order]
    }
}

extension Order {
    
    static func orders(offset: Int, limit: Int, searchText: String = "") -> [Order] {
        let request = NSFetchRequest<Order>(entityName: String(describing: self))
        request.fetchLimit = limit
        request.fetchOffset = offset
        if !searchText.isEmpty {
            let vinPredicate = NSPredicate(format: ("vin CONTAINS[c] %@"), searchText)
            let platePredicate = NSPredicate(format: ("plateNumber CONTAINS[c] %@"), searchText)
            let andPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [vinPredicate, platePredicate])
            request.predicate = andPredicate
        }
        do {
            let orders = try context.fetch(request)
            return orders
        } catch {
            print(error)
            return []
        }
    }
    
    static func byNumber(number: Int) -> Order? {
        let request = NSFetchRequest<Order>(entityName: String(describing: self))
            request.predicate = NSPredicate(format: "number == %@", NSNumber(value: number))
        do {
            let order = try context.fetch(request).first
            return order
        } catch {
            print(error)
            return nil
        }
    }
    
    func toObject() -> OrderModel {
        return OrderModel(orderNumber: Int(self.number),
                                    createDate: self.createDate,
                                    updateDate: self.updateDate,
                                    plateNumber: self.plateNumber,
                                    manufacturer: self.manufacturer,
                                    model: self.model,
                                    status: self.status,
                                    vinNumber: self.vin)
    }

    static func getOrdersFromServer(offset: Int,
                                    limit: Int,
                                    searchText: String,
                                    _ completion: @escaping (Error?) -> Void) {
        let networkProvider = CustomMoyaProvider<CarMasterApi>()
        networkProvider.request(.getCars(offset: offset, limit: limit, searchText: searchText), [OrderModel].self)
        .subscribe(onSuccess: { orders in
            let _ = orders.map { $0.toManagedObject() }
            DataController.shared.save()
            completion(nil)
        },
            onError: {error in
            completion(error)
        })
        .disposed(by: disposeBag)
    }
}

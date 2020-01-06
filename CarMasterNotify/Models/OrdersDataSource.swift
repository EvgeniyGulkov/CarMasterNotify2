import Foundation
import RxSwift
import RxDataSources

struct OrdersDataSource {
    
    var title: String
    var items: [OrderModel]
}
extension OrdersDataSource: SectionModelType {
    
    init(original: OrdersDataSource, items: [OrderModel]) {
        self.items = items
        self.title = original.title
    }
    
    init(items: [OrderModel], title:String) {
        self.items = items
        self.title = title
    }
}

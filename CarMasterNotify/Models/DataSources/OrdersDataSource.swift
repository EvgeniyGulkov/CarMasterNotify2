import Foundation
import RxSwift
import RxDataSources

struct OrdersDataSource {
    
    var title: String
    var items: [Order]
}
extension OrdersDataSource: SectionModelType {
    
    init(original: OrdersDataSource, items: [Order]) {
        self.items = items
        self.title = original.title
    }
    
    init(items: [Order], title:String) {
        self.items = items
        self.title = title
    }
}

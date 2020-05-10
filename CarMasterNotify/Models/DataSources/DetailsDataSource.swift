import Foundation
import RxSwift
import RxDataSources

struct DetailsDataSource {
    var title: String
    var items: [Order]
}

extension DetailsDataSource: SectionModelType {
      typealias Item = Order
    
    init(original: DetailsDataSource, items: [Order]) {
        self = original
        self.items = items
    }
}

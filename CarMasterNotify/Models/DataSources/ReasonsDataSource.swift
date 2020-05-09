import Foundation
import RxSwift
import RxDataSources

struct ReasonDataSource {
    var items: [Item]
}

extension ReasonDataSource: SectionModelType {
      typealias Item = Reason
    
    init(original: ReasonDataSource, items: [Reason]) {
        self = original
        self.items = items
    }
}

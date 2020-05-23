import Foundation
import RxSwift
import RxDataSources

enum CellType {
    case textField
    case button
    case error(error: String)
    case spacer
    case twoButtons
}

extension CellType: IdentifiableType, Equatable {
    var identity: Int {
        return 1
    }
}

struct AuthDataSource {
    var title: String
    var items: [CellType]
}


extension AuthDataSource: AnimatableSectionModelType {
    var identity: String {
        return "a"
    }
    
    typealias Identity = String
    typealias Item = CellType
    
    init(original: AuthDataSource, items: [Item]) {
        self.items = items
        self.title = original.title
    }
    
    init(items: [Item], title:String) {
        self.items = items
        self.title = title
    }
}

import UIKit
import RxSwift

class UserCellViewModel {
    var status: BehaviorSubject<CellState>
    var text: Observable<String>?
    var author: Observable<String>?
    
    init(status: CellState = .complete) {
        self.status = BehaviorSubject(value: status)
    }
}

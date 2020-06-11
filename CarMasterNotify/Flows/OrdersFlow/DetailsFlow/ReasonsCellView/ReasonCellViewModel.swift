import RxSwift

class DetailsCellViewModel {
    var id: String
    var status: BehaviorSubject<CellState>
    var text: Observable<String>?

    init(id: String, status: CellState = .error) {
        self.id = id
        self.status = BehaviorSubject(value: status)
    }
}

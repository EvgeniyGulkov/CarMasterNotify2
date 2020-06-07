import UIKit
import RxSwift
import Moya
import SocketIO
import CoreData

class StationsViewModel {
    let disposeBag = DisposeBag()
    let addButtonTouched = PublishSubject<Void>()

    var user = User(context: DataController.shared.main)
    var selectData: PublishSubject<Station> = PublishSubject()
    var search: PublishSubject<String> = PublishSubject()
    var displayLastCell:PublishSubject<Int> = PublishSubject()
    var data: BehaviorSubject<[StationDataSource]>
    var networkProvider: CustomMoyaProvider<CarMasterApi>
    var selectedCell = PublishSubject<Bool>()

    init(networkProvider: CustomMoyaProvider<CarMasterApi>) {
        self.networkProvider = networkProvider
        let station = Station(context: DataController.shared.main)
        station.name = "AutoTechStation"
        station.address = "Russia, Novosibirsk, Severnaya 15/2"
        let station2 = Station(context: DataController.shared.main)
        station2.name = "RogaiKopita"
        station2.address = "Russia, Novosibirsk, Jopa Mira 1"
        self.data = BehaviorSubject(value: [StationDataSource(title: "", items: [station, station2])])
        
        self.selectData
            .subscribe(onNext: {[weak self] station in
                if let user = User.currentUser {
                    self?.selectedCell.onNext(false)
                    station.user = user
                }
            })
        .disposed(by: disposeBag)
    }
}

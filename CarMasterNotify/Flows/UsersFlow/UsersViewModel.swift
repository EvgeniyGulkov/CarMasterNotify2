import UIKit
import RxSwift
import Moya
import SocketIO
import CoreData

class UsersViewModel {
    let disposeBag = DisposeBag()
    var selectData: PublishSubject<User> = PublishSubject()
    var search: PublishSubject<String> = PublishSubject()
    var displayLastCell:PublishSubject<Int> = PublishSubject()
    var data: PublishSubject<[UsersDataSource]> = PublishSubject()
    var users: [String:User] = [:]
    var socketClient: SocketClient<CarMasterSocketApi>
    var networkProvider: CustomMoyaProvider<CarMasterApi>

    init(networkProvider: CustomMoyaProvider<CarMasterApi>, socketClient: SocketClient<CarMasterSocketApi>) {
        self.networkProvider = networkProvider
        self.socketClient = socketClient

        self.search.asObservable()
            .subscribe(onNext: { text in
                    self.getData(searchText: text.lowercased(), limit: 20, offset: 0)})
            .disposed(by: disposeBag)
    }

    func getData(searchText: String = "", limit: Int = 20, offset: Int = 0) {
        getUsersFromLocalDatabase(searchText: searchText, limit: limit, offset: offset)
        if !searchText.isEmpty {
            self.users.removeAll()
        }
        // get users from backend here
    }

    func getUsersFromLocalDatabase(searchText: String = "", limit: Int = 20, offset: Int = 0) {
        let user = User(context: DataController.shared.main)
        user.accessLevel = AccessLevel.admin.string
        user.firstName = "Vitaly"
        user.lastName = "Cheremnov"
        user.position = "Master"
        self.data.onNext([UsersDataSource(title: "", items: [user])])
    }
}

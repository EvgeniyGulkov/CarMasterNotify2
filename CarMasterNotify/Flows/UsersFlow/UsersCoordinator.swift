import UIKit
import RxSwift
import SocketIO

final class UsersCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    private let factory: UsersModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, factory: UsersModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showUsers()
    }
    
    private func showUsers() {
        let viewModel = ViewModelFactory.makeUsersViewModel()
        viewModel.selectData
            .subscribe({ [unowned self] data in
              //  self.showOrderDetail($0.element!,socketClient: viewModel.socketClient)
            })
            .disposed(by: disposeBag)
        let ordersOutput = factory.makeUsersOutput(viewModel: viewModel)
        router.setRootModule(ordersOutput)
    }
}

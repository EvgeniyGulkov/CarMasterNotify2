import UIKit
import RxSwift
import SocketIO

enum ActionStrings: String {
    case complete = "Complete"
    case cancel = "Cancel"
    case message = "Mark Reason as Complete?"
    case ok = "Ok"
}

final class ServicesCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    private let factory: ServicesModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, factory: ServicesModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showServices()
    }
    
    private func showServices() {
        let viewModel = ViewModelFactory.makeServicesViewModel()
        viewModel.selectData
            .subscribe({ [unowned self] data in
                //self.showOrderDetail($0.element!,socketClient: viewModel.socketClient)
            })
            .disposed(by: disposeBag)
        let servicesOutput = factory.makeServicesOutput(viewModel: viewModel)
        router.setRootModule(servicesOutput)
    }

    private func showSelectService() {
    //    let viewModel = ViewModelFactory.makeSelectCompanyViewModel()
    //    let selectCompanyOutput = factory.makeSelectCompanyOutput(viewModel: viewModel)
    //    router.push(selectCompanyOutput)
    }
}

import UIKit
import RxSwift

final class AuthCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
    private let factory: AuthModuleFactory
    private let router: Router
    private let disposeBag = DisposeBag()
    
    init(router: Router, factory: AuthModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
    private func showLogin() {
        let viewModel = ViewModelFactory.makeLoginViewModel()
        viewModel.signInOk = finishFlow
        let loginOutput = factory.makeLoginOutput(viewModel: viewModel)

        router.setRootModule(loginOutput)
    }
}

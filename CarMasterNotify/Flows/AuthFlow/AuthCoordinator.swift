import UIKit
import RxSwift

final class AuthCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
    private let factory: ModuleFactoryImp
    private let router: Router
    private let disposeBag = DisposeBag()
    
    init(router: Router, factory: ModuleFactoryImp) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
    private func showLogin() {
        let viewModel = ViewModelFactory.makeLoginViewModel()
        viewModel.signInOk = finishFlow
        viewModel.signUp = showSignUpScreen
        let loginOutput = factory.makeLoginOutput(viewModel: viewModel)
        loginOutput.view.backgroundColor = Theme.Color.background
        router.setRootModule(loginOutput)
    }

    private func showSignUpScreen() {
        let viewModel = ViewModelFactory.makeSignUpViewModel()
        viewModel.finishFlow = finishFlow
        let signUpOutput = factory.makeSignUpOutput(viewModel: viewModel)
        router.push(signUpOutput)
    }

    private func showSelectCompany() {
        let viewModel = ViewModelFactory.makeSelectCompanyViewModel()
        viewModel.finishFlow = finishFlow
        let selectCompanyOutput = factory.makeSelectCompanyOutput(viewModel: viewModel)
        router.push(selectCompanyOutput)
    }
}

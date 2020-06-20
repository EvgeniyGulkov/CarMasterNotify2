import RxSwift

final class AuthCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?

    private let factory: ModuleFactoryImp
    private let coordinatorFactory: CoordinatorFactoryImp
    private let router: Router
    private let disposeBag = DisposeBag()

    init(router: Router, coordinatorFactory: CoordinatorFactoryImp, factory: ModuleFactoryImp) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }

    override func start() {
        showLogin()
    }

    private func showLogin() {
        let viewModel = ViewModelFactory.makeLoginViewModel()
        viewModel.finishFlow = finishFlow
        viewModel.signUp = showSignUpScreen
        viewModel.showForgotPassword = startForgotPasswordFlow
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

    private func startForgotPasswordFlow() {
        let coordinator = coordinatorFactory.makeForgotPasswordCoordinator(router: router)
        coordinator.start()
    }
}

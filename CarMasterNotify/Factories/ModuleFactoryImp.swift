import RxSwift

final class ModuleFactoryImp:
    ForgotPasswordFactory,
    AuthModuleFactory,
    OrderModuleFactory,
    SettingsModuleFactory,
    MainModuleFactory,
    DetailsModuleFactory,
    UsersModuleFactory,
StationsModuleFactory {
    let disposeBag = DisposeBag()

    func makeSignUpOutput(viewModel: SignUpViewModel) -> SignUpController {
        let controller = SignUpController.controllerFromStoryboard(.signUp)
        controller.viewModel = viewModel
        return controller
    }

    func makeMainOutput() -> TabbarController {
        let stationsNavigationController = NavigationController()
        let ordersNavigationController = NavigationController()
        let settingsNavigationController = NavigationController()
        let usersNavigationController = NavigationController()

        let controller = TabbarController.controllerFromStoryboard(.main)
        controller.viewControllers = [stationsNavigationController,
                                      ordersNavigationController,
                                      usersNavigationController,
                                      settingsNavigationController]
        controller.delegate = controller
        return controller
    }

    func makeSettingsOutput(viewModel: SettingsViewModel) -> SettingsController {
        let controller = SettingsController.controllerFromStoryboard(.settings)
        controller.viewModel = viewModel
        return controller
    }

    func makeDetailsOutput(viewModel: DetailsViewModel) -> DetailsController {
        let controller = DetailsController.controllerFromStoryboard(.details)
        controller.viewModel = viewModel
        return controller
    }

    func makeMessagesOutput(viewModel: MessageViewModel) -> MessageController {
        let controller = MessageController.controllerFromStoryboard(.message)
        controller.viewModel = viewModel
        return controller
    }

    func makeChangePasswordDialogueOutput(viewModel: PasswordDialogueViewModel) -> PasswordDialogueController {
        let controller = PasswordDialogueController.controllerFromStoryboard(.passwordDialogue)
        controller.viewModel = viewModel
        return controller
    }

    func makeChangeNameDialogueOutput(viewModel: NameChangeViewModel) -> NameChangeDialogueController {
        let controller = NameChangeDialogueController.controllerFromStoryboard(.nameDialogue)
        controller.viewModel = viewModel
        return controller
    }

    func makeOrdersOutput(viewModel: OrderViewModel) -> OrderController {
        let controller = OrderController.controllerFromStoryboard(.orders)
        controller.viewModel = viewModel
        return controller
    }

    func makeLoginOutput(viewModel: LoginViewModel) -> LoginController {
        let controller = LoginController.controllerFromStoryboard(.auth)
        controller.viewModel = viewModel
        return controller
    }

    func makeOrderDetailOutput(viewModel: DetailsViewModel) -> DetailsController {
        let controller = DetailsController.controllerFromStoryboard(.main)
        controller.viewModel = viewModel
        return controller
    }

    func makeUsersOutput(viewModel: UsersViewModel) -> UsersController {
        let controller = UsersController.controllerFromStoryboard(.users)
        controller.viewModel = viewModel
        return controller
    }

    func makeStationsOutput(viewModel: StationsViewModel) -> StationsController {
        let controller = StationsController.controllerFromStoryboard(.stations)
        controller.viewModel = viewModel
        return controller
    }

    func makeAddStationOutput(viewModel: AddStationViewModel) -> AddStationController {
        let controller = AddStationController.controllerFromStoryboard(.addStation)
        controller.viewModel = viewModel
        return controller
    }

    func makeEnterEmailOutput(viewModel: ForgotPasswordEnterEmailViewModel) -> ForgotPasswordEnterEmailController {
        let controller = ForgotPasswordEnterEmailController.controllerFromStoryboard(.forgotPasswordEmail)
        controller.viewModel = viewModel
        return controller
    }

    func makeSendCodeOutput(viewModel: ForgotPasswordEnterEmailViewModel) -> ForgotPasswordEnterEmailController {
        return ForgotPasswordEnterEmailController()
    }
}

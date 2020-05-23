import Foundation
import RxSwift

final class ModuleFactoryImp:
    AuthModuleFactory,
    OrderModuleFactory,
    SettingsModuleFactory,
    MainModuleFactory,
    DetailsModuleFactory,
    SelectCompanyModuleFactory,
    UsersModuleFactory,
    ServicesModuleFactory
{
    let disposeBag = DisposeBag()

    func makeSignUpOutput(viewModel: SignUpViewModel) -> SignUpController {
        let controller = SignUpController.controllerFromStoryboard(.signUp)
        controller.viewModel = viewModel
        return controller
    }

    func makeMainOutput() -> TabbarController {
        let servicesNavigationController = NavigationController()
        let ordersNavigationController = NavigationController()
        let settingsNavigationController = NavigationController()
        let usersNavigationController = NavigationController()

        let controller = TabbarController.controllerFromStoryboard(.main)
        controller.viewControllers = [servicesNavigationController,
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

    func makeServicesOutput(viewModel: ServicesViewModel) -> ServicesController {
        let controller = ServicesController.controllerFromStoryboard(.services)
        controller.viewModel = viewModel
        return controller
    }

    func makeSelectCompanyOutput(viewModel: SelectCompanyViewModel) -> SelectCompanyController {
        let controller = SelectCompanyController.controllerFromStoryboard(.selectCompany)
        controller.viewModel = viewModel
        return controller
    }
}

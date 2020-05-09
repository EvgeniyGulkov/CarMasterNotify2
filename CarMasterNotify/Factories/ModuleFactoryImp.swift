import Foundation
import RxSwift

final class ModuleFactoryImp:
    AuthModuleFactory,
    OrderModuleFactory,
    SettingsModuleFactory,
    MainModuleFactory,
    DetailsModuleFactory
{
    let disposeBag = DisposeBag()

    func makeDetailsTabbarOutput() -> DetailsTabbarController {
        let reasonsNavigationController = NavigationController()
        let messagesNavigationController = NavigationController()
        
        let controller = DetailsTabbarController.controllerFromStoryboard(.detailsTabbar)
             
             controller.viewControllers = [reasonsNavigationController, messagesNavigationController]
             controller.delegate = controller
        
        return controller
    }
        
    func makeMainOutput() -> TabbarController {
        let ordersNavigationController = NavigationController()
        let settingsNavigationController = NavigationController()
        
        let controller = TabbarController.controllerFromStoryboard(.main)
             
             controller.viewControllers = [ordersNavigationController, settingsNavigationController]
             controller.delegate = controller
        
        return controller
    }
    
    func makeSettingsOutput(viewModel: SettingsViewModel) -> SettingsController {
        let controller = SettingsController.controllerFromStoryboard(.settings)
        controller.viewModel = viewModel
        return controller
    }
    
    func makeReasonsOutput(viewModel: ReasonViewModel) -> ReasonsController {
        let controller = ReasonsController.controllerFromStoryboard(.reasons)
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
    
    func makeOrderDetailOutput(viewModel: DetailViewModel) -> DetailsController {
        let controller = DetailsController.controllerFromStoryboard(.main)
        controller.viewModel = viewModel
        return controller
    }
}

import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {

    func makeTabbarCoordinator() -> TabbarCoordinator {
        let coordinator = TabbarCoordinator(coordinatorFactory: CoordinatorFactoryImp(), factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeAuthCoordinatorBox(router: Router) -> AuthCoordinator {
        
        let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }

    func makeOrderCoordinator() -> OrderCoordinator {
        return makeOrderCoordinator(navController: nil)
    }
    
    func makeOrderCoordinator(navController: UINavigationController?) -> OrderCoordinator {
        let coordinator = OrderCoordinator(router: router(navController),
                                           factory: ModuleFactoryImp(),
                                           coordinatorFactory: CoordinatorFactoryImp()
        )
        return coordinator
    }
    
    func makeSettingsCoordinator() -> SettingsCoordinator {
        return makeSettingsCoordinator(navController: nil)
    }
    
    func makeSettingsCoordinator(navController: UINavigationController? = nil) -> SettingsCoordinator {
        let coordinator = SettingsCoordinator(router: router(navController), factory: ModuleFactoryImp())
        return coordinator
    }

    func makeStationsCoordinator() -> StationsCoordinator {
        return makeStationsCoordinator(navController: nil)
    }
    
    func makeStationsCoordinator(navController: UINavigationController? = nil) -> StationsCoordinator {
        let coordinator = StationsCoordinator(router: router(navController),
                                              factory: ModuleFactoryImp(),
                                              coordinatorFactory: CoordinatorFactoryImp())
        return coordinator
    }

    func makeUsersCoordinator() -> UsersCoordinator {
        return makeUsersCoordinator(navController: nil)
    }
    
    func makeUsersCoordinator(navController: UINavigationController?) -> UsersCoordinator {
        let coordinator = UsersCoordinator(router: router(navController),
                                              factory: ModuleFactoryImp(),
                                              coordinatorFactory: CoordinatorFactoryImp())
        return coordinator
    }
    
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController.controllerFromStoryboard(.main) }
    }
}

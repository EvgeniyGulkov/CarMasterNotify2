class TabbarCoordinator: BaseCoordinator {

    private let coordinatorFactory: CoordinatorFactory

    var controller:TabbarController
    var stationsNavController: NavigationController
    var ordersNavController: NavigationController
    var settingsNavController: NavigationController
    var usersNavController: NavigationController
    var finishFlow: (() -> Void)?

    init(coordinatorFactory: CoordinatorFactory,factory: MainModuleFactory) {
        self.coordinatorFactory = coordinatorFactory
        self.controller = factory.makeMainOutput()
        stationsNavController = (controller.viewControllers![0] as? NavigationController)!
        stationsNavController.tabBarItem = UITabBarItem(title: "Stations", image: UIImage(named: "menu"), tag: 0)
        ordersNavController = (controller.viewControllers![1] as? NavigationController)!
        ordersNavController.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(named: "cars_icon"), tag: 1)
        usersNavController = (controller.viewControllers![2] as? NavigationController)!
        usersNavController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "users_icon"), tag: 2)
        settingsNavController = (controller.viewControllers![3] as? NavigationController)!
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_icon"), tag: 3)

    }

    override func start() {
        runStationsFlow(in: self.stationsNavController)
        runOrderFlow(in: self.ordersNavController)
        runUsersFlow(in: self.usersNavController)
        runSettingsFlow(in: self.settingsNavController)
    }

    private func runOrderFlow(in navController: UINavigationController) {
        if navController.viewControllers.isEmpty == true {
            let orderCoordinator = self.coordinatorFactory.makeOrderCoordinator(navController: navController)
            self.addDependency(orderCoordinator)
            orderCoordinator.start()
        }
    }

    private func runSettingsFlow(in navController: UINavigationController) {
        if navController.viewControllers.isEmpty == true {
            let settingsCoordinator = self.coordinatorFactory.makeSettingsCoordinator(navController: navController)
            settingsCoordinator.finishFlow = self.finishFlow
            self.addDependency(settingsCoordinator)
            settingsCoordinator.start()
        }
    }

    private func runStationsFlow(in navController: UINavigationController) {
        if navController.viewControllers.isEmpty == true {
            let stationCoordinator = self.coordinatorFactory.makeStationsCoordinator(navController: navController)
            //stationCoordinator.finishFlow = self.finishFlow
            self.addDependency(stationCoordinator)
            stationCoordinator.start()
        }
    }

    private func runUsersFlow(in navController: UINavigationController) {
        if navController.viewControllers.isEmpty == true {
            let usersCoordinator = self.coordinatorFactory.makeUsersCoordinator(navController: navController)
            //StationCoordinator.finishFlow = self.finishFlow
            self.addDependency(usersCoordinator)
            usersCoordinator.start()
        }
    }
}

import UIKit

class TabbarCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory

    var controller:TabbarController
    var ordersNavController: UINavigationController
    var settingsNavController: UINavigationController
    var finishFlow: (() -> Void)?

    init(coordinatorFactory: CoordinatorFactory,factory: MainModuleFactory) {
        self.coordinatorFactory = coordinatorFactory
        self.controller = factory.makeMainOutput()
        self.ordersNavController = controller.viewControllers![0] as! UINavigationController
        self.settingsNavController = controller.viewControllers![1] as! UINavigationController
    }
    
    override func start() {
        runOrderFlow(in: self.ordersNavController)
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
}

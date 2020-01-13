import UIKit
import KeychainAccess

fileprivate var isAutorized = false

fileprivate enum LaunchInstructor {
    case main, auth

static func configure(isAutorized: Bool = isAutorized) -> LaunchInstructor {
    switch (isAutorized) {
    case true: return .main
    case false: return .auth
        }
    }
}

class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let keychain = Keychain()
    
    private var instructor: LaunchInstructor {
    
        if (try? self.keychain.getString("access_token")) != nil {
           // isAutorized = true
        }
        return LaunchInstructor.configure()
    }
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start(with option: DeepLinkOption?) {
        if let option = option {
            switch option {
            case .signUp: runAuthFlow()
            default: childCoordinators.forEach { coordinator in coordinator.start(with: option)
                }
            }
        } else {
            switch instructor {
                case .auth: runAuthFlow()
                case .main: runMainFlow()
            }
        }
    }
    
    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinatorBox(router: router)
        coordinator.finishFlow = {[weak self,weak coordinator] in
            isAutorized = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        UserDefaults.standard.set(true, forKey: "notificationsOn")
        
        let coordinator = coordinatorFactory.makeTabbarCoordinator()
        addDependency(coordinator)
        router.setRootModule(coordinator.controller, hideBar: true)
        coordinator.start()
    }
}

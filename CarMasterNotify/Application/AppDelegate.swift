import UIKit
import RxKeyboard
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController:UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        let navController = NavigationController()
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        
        let notification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: notification)
        applicationCoordinator.start(with: deepLink)
        return true
    }
    
    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(router: RouterImp(rootController: self.rootController), coordinatorFactory: CoordinatorFactoryImp())
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        let dict = userInfo as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: dict)
        applicationCoordinator.start(with: deepLink)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let deepLink = DeepLinkOption.build(with: userActivity)
        applicationCoordinator.start(with: deepLink)
        return true
    }


}

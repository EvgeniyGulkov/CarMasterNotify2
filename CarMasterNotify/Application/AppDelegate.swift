import RxKeyboard
import RxSwift
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UINavigationController {
        let controller = self.window!.rootViewController as? UINavigationController
        return controller ?? UINavigationController()
    }

    lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = NavigationController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        let persistentContainer = NSPersistentContainer(name: "CarMasterNotifyData")
        DataController.create(persistentContainer: persistentContainer) {
            let notification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: AnyObject]
            let deepLink = DeepLinkOption.build(with: notification)
            self.applicationCoordinator.start(with: deepLink)
        }
        return true
    }

    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(router: RouterImp(rootController: self.rootController),
                                      coordinatorFactory: CoordinatorFactoryImp())
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        let dict = userInfo as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: dict)
        applicationCoordinator.start(with: deepLink)
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let deepLink = DeepLinkOption.build(with: userActivity)
        applicationCoordinator.start(with: deepLink)
        return true
    }

}

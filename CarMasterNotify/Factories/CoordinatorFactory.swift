import UIKit

protocol CoordinatorFactory {
    func makeTabbarCoordinator() -> TabbarCoordinator
        
    func makeAuthCoordinatorBox(router: Router) -> AuthCoordinator
    
    func makeOrderCoordinator(navController: UINavigationController?) -> OrderCoordinator
    func makeOrderCoordinator() -> OrderCoordinator
    
    func makeSettingsCoordinator() -> SettingsCoordinator
    func makeSettingsCoordinator(navController: UINavigationController?) -> SettingsCoordinator

    func makeStationsCoordinator() -> StationsCoordinator
    func makeStationsCoordinator(navController: UINavigationController?) ->
        StationsCoordinator

    func makeUsersCoordinator() -> UsersCoordinator
    func makeUsersCoordinator(navController: UINavigationController?) ->
        UsersCoordinator
}

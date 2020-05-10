import UIKit

final class TabbarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        self.tabBar.barTintColor = Theme.Color.barColor
        self.tabBar.tintColor = Theme.Color.greenColor
    }
}

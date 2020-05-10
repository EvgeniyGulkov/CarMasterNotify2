import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = .blackOpaque
        self.navigationBar.barTintColor = Theme.Color.background
        self.navigationBar.tintColor = UIColor.white
        self.isToolbarHidden = true
    }
}
 

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = Theme.Color.barColor
        self.navigationBar.setBackgroundImage(Theme.Color.background.image(), for: .compact)
        self.navigationBar.tintColor = UIColor.white
        self.isToolbarHidden = true
    }
}
 

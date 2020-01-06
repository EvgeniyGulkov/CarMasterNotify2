import UIKit

class NavigationController: UINavigationController {
    let barColor = UIColor.init(red: 72/255, green: 109/255, blue: 161/255, alpha: 255)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = .blackTranslucent
        self.navigationBar.barTintColor = barColor
        self.navigationBar.tintColor = UIColor.white
        self.isToolbarHidden = true
        self.toolbar.barStyle = .blackTranslucent
        self.toolbar.barTintColor = barColor
    }
}
 

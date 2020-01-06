import UIKit

class RoundCornerTextField:UITextField {
    let borderColor = UIColor.init(red: 72/255, green: 109/255, blue: 161/255, alpha: 255).cgColor
    let placeholderColor = UIColor.init(red: 72/255, green: 109/255, blue: 161/255, alpha: 255).cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        layer.masksToBounds = true
        layer.borderColor = borderColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5
    }
}

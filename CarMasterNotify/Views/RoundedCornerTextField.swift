import UIKit

class RoundedCornerTextField: UITextField {
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
        self.backgroundColor = UIColor.white
        layer.cornerRadius = 15
    }

}

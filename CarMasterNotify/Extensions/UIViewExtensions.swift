extension UIView {

    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    // swiftlint:disable force_cast
    private class func viewInNibNamed<T: UIView>(_ nibNamed: String) -> T {
        return Bundle.main.loadNibNamed(nibNamed, owner: nil, options: nil)!.first as! T
    }
    // swiftlint:enable force_cast

    class func nib() -> Self {
        return viewInNibNamed(nameOfClass)
    }

    class func nib(_ frame: CGRect) -> Self {
        let view = nib()
        view.frame = frame
        view.layoutIfNeeded()
        return view
    }

    class func loadFromNib<T>(withName nibName: String) -> T? {
            let nib  = UINib.init(nibName: nibName, bundle: nil)
            let nibObjects = nib.instantiate(withOwner: nil, options: nil)
            for object in nibObjects {
                if let result = object as? T {
                    return result
                }
            }
            return nil
        }
}

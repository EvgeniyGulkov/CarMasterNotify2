extension UIViewController {
    // swiftlint:disable force_cast
    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard,
                                                                              identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T // Not triggers a warning
    }
    // swiftlint:enable force_cast

    class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        return instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }

    class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        return controllerInStoryboard(storyboard, identifier: nameOfClass)
    }

    class func controllerFromStoryboard(_ storyboard: Storyboards) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: nameOfClass)
    }

    func animate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

}

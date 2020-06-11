open class CircularProgressBar: UIView {

    var darkBorderLayer:BorderLayer!
    var progressBorderLayer:BorderLayer!

    static let startAngle = 3/2*CGFloat.pi
    static let endAngle = 7/2*CGFloat.pi

    internal class func radianForValue(_ value:CGFloat) -> CGFloat {
        return (value * 4/2 * CGFloat.pi / 100) + CircularProgressBar.startAngle
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    open func commonInit() {
        darkBorderLayer = BorderLayer()
        darkBorderLayer.lineColor = UIColor(
        red: 100/255,
        green: 150/255,
        blue: 200/255,
        alpha: 0.0
        ).cgColor
        darkBorderLayer.startAngle = CircularProgressBar.startAngle
        darkBorderLayer.endAngle = CircularProgressBar.endAngle
        self.layer.addSublayer(darkBorderLayer)
        progressBorderLayer = BorderLayer()
        progressBorderLayer.lineColor = UIColor(
            red: 100/255,
            green: 150/255,
            blue: 200/255,
            alpha: 1
        ).cgColor
        progressBorderLayer.startAngle = CircularProgressBar.radianForValue(40)
        progressBorderLayer.endAngle = CircularProgressBar.radianForValue(0)
        self.layer.addSublayer(progressBorderLayer)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        darkBorderLayer.frame = self.bounds
        progressBorderLayer.frame = self.bounds
        darkBorderLayer.setNeedsDisplay()
        progressBorderLayer.setNeedsDisplay()
    }
}

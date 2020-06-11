//
//  BorderLayer.swift
//  CircularProgressBar
//
//  Created by Evgeniy on 14/09/2019.
//  Copyright © 2019 Evgeniy. All rights reserved.
//

class BorderLayer: CALayer {
    var lineWidth:CGFloat = 2.0
    var lineColor:CGColor = UIColor.blue.cgColor
    var startAngle:CGFloat = 0.0
    @NSManaged var endAngle:CGFloat

    override func draw(in ctx: CGContext) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        ctx.beginPath()
        ctx.setStrokeColor(lineColor)
        ctx.setLineWidth(lineWidth)
        ctx.addArc(center: center,
                   radius: bounds.height/2 - lineWidth,
                   startAngle: startAngle,
                   endAngle: endAngle,
                   clockwise: false)
        ctx.drawPath(using: .stroke)
    }

    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "endAngle" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
}

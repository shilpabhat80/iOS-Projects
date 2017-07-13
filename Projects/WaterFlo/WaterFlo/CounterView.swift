//
//  CounterView.swift
//  WaterFlo
//
//  Created by Shilpa Bhat on 25/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//


import UIKit

let numberOfGlasses = 8
//let ∏ = M_PI

@IBDesignable class CounterView: UIView {

    @IBInspectable var counter:Int = 5 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var fillColor:UIColor = UIColor.green {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var outlineColor:UIColor = UIColor.black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var counterColor:UIColor = UIColor.black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = max(bounds.width, bounds.height)
        
        let pi = CGFloat(Double.pi)
        
        let startAngle = 3.0 * pi / 4
        let endAngle = pi / 4
        
        let arcWidth: CGFloat = 76

        fillColor.setStroke()
        let fillPath = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2,
                                    startAngle: startAngle,
                                    endAngle: endAngle, clockwise: true)
        fillPath.lineWidth = arcWidth
        fillPath.stroke()
        
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * pi - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(numberOfGlasses)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        //4 - close the path
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }
}

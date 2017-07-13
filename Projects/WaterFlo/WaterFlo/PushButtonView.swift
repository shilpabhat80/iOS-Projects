//
//  PushButtonView.swift
//  WaterFlo
//
//  Created by Shilpa Bhat on 25/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

@IBDesignable class PushButtonView: UIButton {
 
    @IBInspectable var fillColor:UIColor = UIColor.green {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var isAddButton:Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        fillColor.setFill()

        let ovalPath = UIBezierPath(ovalIn: bounds)
        ovalPath.fill()
        
        let lineWidth:CGFloat = 5.0
        let plusWidth:CGFloat = min(bounds.width , bounds.height) * 0.6

        let plusPath = UIBezierPath()
        UIColor.white.setStroke()

        plusPath.lineWidth = lineWidth
        plusPath.move(to: CGPoint(x: (bounds.width/2 - plusWidth/2), y: bounds.height/2))
        plusPath.addLine(to: CGPoint(x: (bounds.width/2 + plusWidth/2), y: bounds.height/2))
        plusPath.stroke()
        if isAddButton {
            plusPath.move(to: CGPoint(x: bounds.width/2, y: (bounds.height/2 - plusWidth/2)))
            plusPath.addLine(to: CGPoint(x: bounds.width/2, y: (bounds.height/2 + plusWidth/2)))
            plusPath.stroke()
        }
    }
}

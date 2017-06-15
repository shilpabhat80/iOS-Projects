//
//  Extensions.swift
//  YouTube
//
//  Created by Shilpa Bhat on 23/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(_ red: Float, _ green: Float, _ blue: Float, _ alpha: Float) -> UIColor
    {
        return UIColor(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

extension UIView
{
    func addConstraintsWithName(_ name:String, views:UIView...) {
        
        var viewsDict = [String:Any]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: name, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

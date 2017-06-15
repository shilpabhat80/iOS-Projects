//
//  Extension.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 26/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static var pantonBlue:UIColor  {
        get {
            return rgb(46, 139, 227) // #2E8BF7
        }
    }
}

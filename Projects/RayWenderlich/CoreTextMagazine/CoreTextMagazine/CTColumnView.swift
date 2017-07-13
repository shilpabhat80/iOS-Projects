//
//  CTColumnView.swift
//  CoreTextMagazine
//
//  Created by Shilpa Bhat on 25/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import CoreText

class CTColumnView: UIView {
    
    // MARK: - Properties
    var ctFrame:CTFrame!
    
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, ctFrame:CTFrame) {
        super.init(frame: frame)
        
        self.ctFrame = ctFrame
        backgroundColor = UIColor.white
        
    }
    
    // MARK: - Life Cycle
    override func draw(_ rect: CGRect) {
        
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        CTFrameDraw(rect, context)
    }
    
}

//
//  CTView.swift
//  CoreTextMagazine
//
//  Created by Shilpa Bhat on 25/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import CoreText

class CTView: UIScrollView {
    
    // MARK: - Properties
    var attrString: NSAttributedString!
    
    // MARK: - Internal
    func importAttrString(_ attrString: NSAttributedString) {
        self.attrString = attrString
    }
    
    override func draw(_ rect: CGRect) {
        
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        
        // 3
        let path = CGMutablePath()
        path.addRect(bounds)
        
        guard let attrStr = attrString else {return}
        // 5
        let framesetter = CTFramesetterCreateWithAttributedString(attrStr as CFAttributedString)
        // 6
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, nil)
        // 7
        CTFrameDraw(frame, context)
    }
    
}

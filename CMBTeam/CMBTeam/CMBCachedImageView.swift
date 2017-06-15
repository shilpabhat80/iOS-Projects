//
//  CMBCachedImageView.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 26/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
/**
 A convenient UIImageView to load and cache images.
 */
@IBDesignable
public class CMBCachedImageView: UIImageView {
    
    @IBInspectable
    public var isRounded:Bool = false
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 0
    }
    
    override public var image: UIImage? {
        willSet {
            if isRounded == true {
                layer.cornerRadius = 32
                layer.borderColor = UIColor.pantonBlue.cgColor
                layer.borderWidth = 3
            }
        }
    }
    
    func loadImage(urlString:String, withInitials initials:String?) {
        //Nuke.loadImage(with: URL(string:urlString)!, into: self)
        self.image = UIImage(named: "User")
        CMBPhotoCacheManager.shared.loadImage(urlString: urlString, withInitials:initials) { (image) in
            DispatchQueue.main.async {
                self.image = image!
            }
        }
    }

}

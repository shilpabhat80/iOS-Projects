//
//  MenuCell.swift
//  YouTube
//
//  Created by Shilpa Bhat on 23/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class MenuCell: BaseCollectionViewCell {

    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "reply")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(91, 14, 13, 1.0)
        
        return iv
    }()

    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(91, 14, 13, 1.0)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(91, 14, 13, 1.0)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(imageView)
        addConstraintsWithName("H:[v0(28)]", views: imageView)
        addConstraintsWithName("V:[v0(20)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}


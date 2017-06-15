//
//  BaseCollectionViewCell.swift
//  YouTube
//
//  Created by Shilpa Bhat on 23/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    func setUpViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
}

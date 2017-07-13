//
//  Post.swift
//  FaceBookFeed
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class Post {
    var name:String?
    var statusText:String?
    var statusImageURL:String?
    
    var displayName: NSAttributedString {
        get {
            let attributedText = NSMutableAttributedString(string: name!, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "\nDec 18 - San Franscisco", attributes: [NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 10)]))
            return attributedText
        }
    }
}

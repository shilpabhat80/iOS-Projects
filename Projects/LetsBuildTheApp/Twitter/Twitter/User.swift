//
//  User.swift
//  Twitter
//
//  Created by Shilpa Bhat on 30/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import SwiftyJSON
import TRON

struct User : JSONDecodable {
    let name: String
    let userName: String
    let bioText: String
    let profileImage: UIImage
    let profileImageUrl: String
    
    init(json: JSON)
    {
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImageUrl = json["profileImageUrl"].stringValue
        self.profileImage = UIImage()
    }
}

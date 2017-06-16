//
//  CMBPerson.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 25/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import SwiftyJSON

struct CMBPerson {
    var avatar: String = ""
    var bio:String = ""
    var firstName:String = ""
    var id:String = ""
    var lastName:String = ""
    var title:String = ""

    
    var initials: String? {
        get {
            
            let firstNameChar = firstName.uppercased().characters.first!
            let lastNameChar = lastName.uppercased().characters.first!
            return "\(firstNameChar)\(lastNameChar)"
        }
    }
    
    init?(json: JSON) throws {
        
        self.avatar = json["avatar"].stringValue
        self.bio = json["bio"].stringValue
        self.firstName = json["firstName"].stringValue
        self.id = json["id"].stringValue
        self.lastName = json["lastName"].stringValue
        self.title = json["title"].stringValue
    }

    
    init?(json: [String: Any]) throws {
        
        if let avatar = json["avatar"] as? String {
            self.avatar = avatar
        }
        if let bio = json["bio"] as? String {
            self.bio = bio
        }
        if let firstName = json["firstName"] as? String {
            self.firstName = firstName
        }
        if let id = json["id"] as? String {
            self.id = id
        }
        if let lastName = json["lastName"] as? String {
            self.lastName = lastName
        }
        if let title = json["title"] as? String {
            self.title = title
        }
    }
}

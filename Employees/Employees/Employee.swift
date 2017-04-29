//
//  Employee.swift
//  Employees
//
//  Created by Shilpa Bhat on 5/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation

class Employee: NSObject {
    var id:String = ""
    var name:String = ""
    var phone:String = ""
    var username:String = ""
    var email:String = ""
    
    init?(json: [String: Any]) {
        
        if let id = json["id"] as? String {
            self.id = id
        }
        if let name = json["name"] as? String {
            self.name = name
        }
        if let phone = json["phone"] as? String {
            self.phone = phone
        }
        if let username = json["username"] as? String {
            self.username = username
        }
        if let email = json["email"] as? String {
            self.email = email
        }
    }
}



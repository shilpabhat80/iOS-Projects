//
//  Tweet.swift
//  Twitter
//
//  Created by Shilpa Bhat on 1/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct Tweet : JSONDecodable {
    let user: User
    let message: String

    init(json: JSON) {
        self.user = User(json:json["user"])
        self.message = json["message"].stringValue
    }

}

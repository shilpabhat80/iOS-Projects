//
//  Service.swift
//  Twitter
//
//  Created by Shilpa Bhat on 3/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    static let sharedInstance = Service()
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Error")
        }
    }
    
    func fetchHomeFeed(completion:@escaping (HomeDataSource?, Error?)->()) {
        
        let request: APIRequest<HomeDataSource,JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (homeDataSource) in
            completion(homeDataSource, nil)
        })
        { (err) in
            completion(nil, err)
        }
        request.method = .get
    }
}

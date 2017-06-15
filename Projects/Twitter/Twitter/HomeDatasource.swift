//
//  HomeDatasource.swift
//  Twitter
//
//  Created by Shilpa Bhat on 30/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

extension Collection where Iterator.Element == JSON {
    func decode<T: JSONDecodable>() throws ->[T] {
        return try map {try T(json: $0) }
    }
}

class HomeDataSource: Datasource, JSONDecodable {
    
    let users:[User]
    let tweets:[Tweet]
   
    required init(json: JSON) throws {
        
        guard let usersJSONArray = json["users"].array,
        let tweetsJSONArray = json["tweets"].array else {
            throw NSError(domain: "com.letsbuildthatapp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error in parsing JSON response."])
        }
        
        self.users = try usersJSONArray.decode()
        self.tweets = try tweetsJSONArray.decode()
    }

    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeaderCell.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooterCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
   
    override func item(_ indexPath: IndexPath) -> Any? {
        
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
}

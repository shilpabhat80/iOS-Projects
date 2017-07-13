//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Shilpa Bhat on 16/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {
    
    private var tweets = [Tweet]()
    
    var searchText: String? {
        didSet {
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    
    private func searchForTweets() {
        
    }
    
    override func veiwDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension TweetTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
}

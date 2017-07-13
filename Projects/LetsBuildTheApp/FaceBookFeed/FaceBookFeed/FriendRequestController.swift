//
//  FriendRequestController.swift
//  FaceBookFeed
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

let cellId = "FriendRequestCellId"
class FriendRequestController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Friend Request"
        
        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friendRequestCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return friendRequestCell
    }
}



//
//  FeedTabBarController.swift
//  FaceBookFeed
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class FeedTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNavController = UINavigationController(rootViewController: feedController)
        feedNavController.title = "News Feed"
        feedNavController.tabBarItem.image = #imageLiteral(resourceName: "news_feed_icon")
        
        let friendRequestController = FriendRequestController()
        let friendRequestNavController = UINavigationController(rootViewController: friendRequestController)
        friendRequestNavController.title = "Requester"
        friendRequestNavController.tabBarItem.image = #imageLiteral(resourceName: "requests_icon")
        
        let messangerNavController = UINavigationController(rootViewController: UIViewController())
        messangerNavController.title = "Messanger"
        messangerNavController.tabBarItem.image = #imageLiteral(resourceName: "messenger_icon")
        
        let notificationNavController = UINavigationController(rootViewController: UIViewController())
        notificationNavController.title = "Notifications"
        notificationNavController.tabBarItem.image = #imageLiteral(resourceName: "globe_icon")
        
        let moreNavController = UINavigationController(rootViewController: UIViewController())
        moreNavController.title = "More"
        moreNavController.tabBarItem.image = #imageLiteral(resourceName: "more_icon")
        
        viewControllers = [feedNavController, friendRequestNavController,messangerNavController, notificationNavController, moreNavController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}

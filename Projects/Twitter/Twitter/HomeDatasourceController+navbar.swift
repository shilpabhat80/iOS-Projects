//
//  HomeDatasourceController+navbar.swift
//  Twitter
//
//  Created by Shilpa Bhat on 4/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

extension HomeDatasourceController {
    func setUpNavigationButtons()
    {
        setUpLeftNavItems()
        setUpRightNavItems()
        setUpRemainingNavItems()
    }
    
    private func setUpRemainingNavItems() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "title_icon"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setUpLeftNavItems() {
        let followButton = UIButton(type:.system)
        followButton.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 50, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
    }
    
    private func setUpRightNavItems() {
        let composeButton = UIButton(type:.system)
        composeButton.setImage(#imageLiteral(resourceName: "compose"), for: .normal)
        composeButton.frame = CGRect(x: 0, y: 0, width:34, height:34)
        
        let searchButton = UIButton(type:.system)
        searchButton.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width:34, height: 34)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView:composeButton), UIBarButtonItem(customView:searchButton)]
    }
}

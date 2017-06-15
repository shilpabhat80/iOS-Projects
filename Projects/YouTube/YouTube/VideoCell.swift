//
//  VideoCell.swift
//  YouTube
//
//  Created by Shilpa Bhat on 23/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class VideoCell: BaseCollectionViewCell {
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var userProfileImageView: UIImageView = {
        let pofileImageView = UIImageView()
        pofileImageView.backgroundColor = UIColor.green
        pofileImageView.layer.cornerRadius = 22
        pofileImageView.layer.masksToBounds = true
        return pofileImageView
    }()
    
    var sepratorView: UIView = {
        let sepratorView = UIView()
        sepratorView.backgroundColor = UIColor.blue
        return sepratorView
    }()
    
    var videoTitle: UILabel = {
        let videoTitleView = UILabel()
        videoTitleView.translatesAutoresizingMaskIntoConstraints = false
        videoTitleView.text = "Taylor Swift"
        return videoTitleView
    }()
    
    var videoDesc: UITextView = {
        let videoDescView = UITextView()
        videoDescView.translatesAutoresizingMaskIntoConstraints = false
        videoDescView.text = "Taylor Swift - 1000000 views - 2 likes - 2 years ago"
        videoDescView.textColor = UIColor.lightGray
        return videoDescView
    }()

    override func setUpViews()
    {
        super.setUpViews()
        
        addSubview(thumbnailImageView)
        addSubview(sepratorView)
        addSubview(userProfileImageView)
        addSubview(videoTitle)
        addSubview(videoDesc)
        
        addConstraintsWithName("H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithName("H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithName("H:|[v0]|", views: sepratorView)
        
        addConstraintsWithName("V:|-16-[v0]-8-[v1(44)]-8-[v2(1)]|", views: thumbnailImageView, userProfileImageView,sepratorView)
        addConstraint(NSLayoutConstraint(item: videoTitle, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: videoTitle, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: videoTitle, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: videoTitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: videoDesc, attribute: .top, relatedBy: .equal, toItem: videoTitle, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: videoDesc, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: videoDesc, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: videoDesc, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
    
}

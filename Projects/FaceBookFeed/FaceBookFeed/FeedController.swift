//
//  FeedController.swift
//  FaceBookFeed
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

let FeedCellId = "FeedCellId"
class FeedController: UICollectionViewController {
    
    var posts = [Post]()
    
    private func loadPosts() {
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusImageURL = "https://media.licdn.com/media/AAEAAQAAAAAAAAPuAAAAJDcxZGJjZDlhLTYzMjUtNDFhZi1hYzFjLWM1MmEzNGVlODRmMw.jpg"
        postMark.statusText = "By giving people the power to share, we're making the world more transparent. A squirrel dying in front of your house may be more relevant to your interests right now than people dying in Africa. I think a simple rule of business is, if you do the things that are easier first, then you can actually make a lot of progress."
        posts.append(postMark)
        
        let postJobs = Post()
        postJobs.name = "Steve Jobs"
        postJobs.statusImageURL = "https://d1qb2nb5cznatu.cloudfront.net/users/114349-large?1462395805"
       postJobs.statusText = "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Innovation distinguishes between a leader and a follower. Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations. Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it."
        posts.append(postJobs)
        
        let postGandhi = Post()
        postGandhi.name = "Gandhi"
        postGandhi.statusImageURL = "https://d1qb2nb5cznatu.cloudfront.net/users/1403369-large?1462495512"
        postGandhi.statusText = "You must be the change you wish to see in the world. The weak can never forgive. Forgiveness is the attribute of the strong. Happiness is when what you think, what you say, and what you do are in harmony."
        posts.append(postGandhi)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosts()
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: FeedCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCellId, for: indexPath) as! FeedCell
        let post = self.posts[indexPath.row]
        
        feedCell.post = post
        feedCell.nameLabel.attributedText = post.displayName
        if let statusText = post.statusText {
            feedCell.statusTextView.text = statusText
        }
        return feedCell
    }
}

extension FeedController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let post = self.posts[indexPath.row]
        if let statusText = post.statusText as NSString? {
            let frameSize = CGSize(width: view.frame.width, height: 1000)
            let rect = statusText.boundingRect(with: frameSize
                , options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], context: nil)
            let knownHeight:CGFloat = 400.0
            return CGSize(width: view.frame.width, height: rect.height + knownHeight)
        }
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}


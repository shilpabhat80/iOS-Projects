//
//  TweetCell.swift
//  Twitter
//
//  Created by Shilpa Bhat on 1/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import LBTAComponents

class TweetCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let tweet =  datasourceItem as? Tweet else { return }
            
            profileImageView.loadImage(urlString: tweet.user.profileImageUrl)
            
            let attributedText = NSMutableAttributedString(string: tweet.user.name,
                                                           attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)])
            let userNameString = " " + tweet.user.userName + "\n"
            attributedText.append(NSMutableAttributedString(string: userNameString,
                                                            attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                                                                         NSForegroundColorAttributeName: UIColor.gray]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let range = NSMakeRange(0, attributedText.string.characters.count)
            attributedText.addAttributes([NSParagraphStyleAttributeName : paragraphStyle], range: range)
            
            attributedText.append(NSMutableAttributedString(string: tweet.message,
                                                            attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]))
            
            messageTextVeiw.attributedText = attributedText

        }
    }
    
    let messageTextVeiw: UITextView = {
        let tv = UITextView()
        tv.text = "Some sample text"
        tv.backgroundColor = .clear
        return tv
    }()
    
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = UIImage()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let replyButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "reply"), for: .normal)
        return button
    }()
    
    let reTweetButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        return button
    }()

    let likeButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        return button
    }()
    
    let directMessageButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send_message"), for: .normal)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        profileImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        addSubview(messageTextVeiw)
        messageTextVeiw.anchor(topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
       setupBottomButtons()
    }
    
    private func setupBottomButtons() {
        
        let replyButtonContainerView = UIView()
        
        let retweetButtonContainerView = UIView()
        
        let likeButtonContainerView = UIView()

        let directMessageButtonContainerView = UIView()

        let buttonStackView = UIStackView(arrangedSubviews: [replyButtonContainerView, retweetButtonContainerView, likeButtonContainerView, directMessageButtonContainerView])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(nil, left: messageTextVeiw.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 4, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        addSubview(replyButton)
        replyButton.anchor(replyButtonContainerView.topAnchor, left: replyButtonContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)

        addSubview(reTweetButton)
        reTweetButton.anchor(retweetButtonContainerView.topAnchor, left: retweetButtonContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)

        addSubview(likeButton)
        likeButton.anchor(likeButtonContainerView.topAnchor, left: likeButtonContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        addSubview(directMessageButton)
        directMessageButton.anchor(directMessageButtonContainerView.topAnchor, left: directMessageButtonContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
    }
}

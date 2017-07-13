//
//  FeedCell.swift
//  FaceBookFeed
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var post:Post? {
        didSet {

            if let imageURLString = post?.statusImageURL,
                let url =  URL(string: imageURLString) {
                let urlRequest = URLRequest(url: url)
                URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                    if let image = UIImage(data: data!) {
                        OperationQueue.main.addOperation {
                            self?.statusImageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Family")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 12)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Family")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likeCommentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "408 Likes    10.7k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    static func button(title:String, image:String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 263), for: .normal)
        button.setImage(UIImage(named:image), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }
    
    let likeButton = FeedCell.button(title: "Like", image: "like")
    let commentButton: UIButton = FeedCell.button(title: "Comments", image: "comment")
    let shareButton: UIButton = FeedCell.button(title: "Share", image: "share")
    
    let actionHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private func setupViews() {
        horizontalStackView.addArrangedSubview(profileImageView)
        horizontalStackView.addArrangedSubview(nameLabel)
        
        actionHorizontalStackView.addArrangedSubview(likeButton)
        actionHorizontalStackView.addArrangedSubview(commentButton)
        actionHorizontalStackView.addArrangedSubview(shareButton)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(statusTextView)
        verticalStackView.addArrangedSubview(statusImageView)
        verticalStackView.addArrangedSubview(likeCommentsLabel)
        verticalStackView.addArrangedSubview(dividerLine)
        verticalStackView.addArrangedSubview(actionHorizontalStackView)
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate(
            [profileImageView.widthAnchor.constraint(equalToConstant: 44),
             horizontalStackView.heightAnchor.constraint(equalToConstant: 44),
             statusImageView.heightAnchor.constraint(equalToConstant: 200),
             likeCommentsLabel.heightAnchor.constraint(equalToConstant: 30),
             dividerLine.heightAnchor.constraint(equalToConstant: 1),
             actionHorizontalStackView.heightAnchor.constraint(equalToConstant: 44),
             verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
             verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
             verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             ]
        )
    }
}

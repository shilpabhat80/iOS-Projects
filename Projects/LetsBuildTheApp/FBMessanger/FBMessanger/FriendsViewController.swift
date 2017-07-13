//
//  FriendsViewController.swift
//  FBMessanger
//
//  Created by Shilpa Bhat on 9/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

let CellId = "CellId"

class FriendsViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        view.backgroundColor = .white
        collectionView?.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: CellId)
    }
}

extension FriendsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath)
    }
}


extension FriendsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 84)
    }
}

class FriendCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {

        backgroundColor = UIColor.white
        
        nameTimeStackView.addArrangedSubview(nameLabel)
        nameTimeStackView.addArrangedSubview(timeLabel)
        
        messagePhotoStackView.addArrangedSubview(messageLabel)
        messagePhotoStackView.addArrangedSubview(hasReadImageView)
    
        userDescStackView.addArrangedSubview(nameTimeStackView)
        userDescStackView.addArrangedSubview(messagePhotoStackView)
        
        userStackView.addArrangedSubview(profileImageView)
        userStackView.addArrangedSubview(userDescStackView)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(userStackView)
        
        NSLayoutConstraint.activate(
            [
                profileImageView.widthAnchor.constraint(equalToConstant: 68),
             profileImageView.heightAnchor.constraint(equalToConstant: 68),
             
             //userDescStackView.heightAnchor.constraint(equalToConstant: 40),
             
             userStackView.topAnchor.constraint(equalTo:topAnchor, constant: 8),
             userStackView.bottomAnchor.constraint(equalTo:topAnchor, constant: -8),
             userStackView.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 12),
             userStackView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -12),
             ])
        
    }
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "mark")
        return imageView
    }()
    
    private let dividerLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Friend's Name"
        return label
    }()
    
    private let messageLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.text = "Your Friend's Message is to be more social"
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let timeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.text = "12:00 AM"
        return label
    }()
    
    private let hasReadImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "mark")
        return imageView
    }()

    
    private let nameTimeStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let messagePhotoStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    
    private let userDescStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let userStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 8

        return stackView
    }()
}


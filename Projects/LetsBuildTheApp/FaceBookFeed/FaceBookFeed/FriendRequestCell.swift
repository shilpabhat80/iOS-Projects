//
//  FriendRequestCell.swift
//  FaceBookFeed
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class FriendRequestCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Tim Cook"
        return label
    }()
    
    let acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
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
        horizontalStackView.addArrangedSubview(acceptButton)
        horizontalStackView.addArrangedSubview(cancelButton)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate(
            [
                verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                ]
        )
    }
}

//
//  AppCell.swift
//  AppStore
//
//  Created by Shilpa Bhat on 13/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Disney: Build it - Frozen"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Entertainment"
        label.textColor = .darkGray
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "$3.99"
        label.textColor = .darkGray
        return label
    }()
    
    let appInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()

   
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        appInfoStackView.addArrangedSubview(imageView)
        appInfoStackView.addArrangedSubview(nameLabel)
        appInfoStackView.addArrangedSubview(categoryLabel)
        appInfoStackView.addArrangedSubview(priceLabel)

        addSubview(appInfoStackView)
        imageView.image = #imageLiteral(resourceName: "Georgia1")
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: frame.width),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            appInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            appInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            appInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            appInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            ])
    }
}

//
//  CategoryCell.swift
//  AppStore
//
//  Created by Shilpa Bhat on 12/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Best Disney Apps"
        return label
    }()
    
    let appCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    let appCellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    func setupViews() {
        backgroundColor = UIColor.clear
        
        appCellStackView.addArrangedSubview(titleLabel)
        appCellStackView.addArrangedSubview(appCollectionView)
        appCellStackView.addArrangedSubview(dividerLine)
        
        addSubview(appCellStackView)
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        
        appCollectionView.register(AppCell.self, forCellWithReuseIdentifier: "AppCellId")
        NSLayoutConstraint.activate([
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            titleLabel.heightAnchor.constraint(equalToConstant: 23),
            appCellStackView.topAnchor.constraint(equalTo: topAnchor),
            appCellStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            appCellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            appCellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCellId", for: indexPath) as! AppCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 40)
    }
}



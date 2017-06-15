//
//  MenuBar.swift
//  YouTube
//
//  Created by Shilpa Bhat on 23/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let CellId = "CellId"
    let images = ["home", "subscriptions", "trending", "account"]

    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(230.0, 32.0, 32.0, 1.0)
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView
            .register(MenuCell.self, forCellWithReuseIdentifier: CellId)

        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)
        addConstraintsWithName("H:|[v0]|", views: collectionView)
        addConstraintsWithName("V:|[v0]|", views: collectionView)
        
        let selIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: images[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor.rgb(91, 14, 13, 1.0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

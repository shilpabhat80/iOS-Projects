//
//  CMBPersonCollectionViewController.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 26/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class CMBPersonCollectionViewController: UICollectionViewController {
    
    var person : CMBPerson?
    
    let photoImageView: CMBCachedImageView = {
        let iv = CMBCachedImageView()
        iv.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        return iv
    }()
    
    let backgroundView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundView = backgroundView
        backgroundView.addSubview(photoImageView)
        photoImageView.loadImage(urlString: (person?.avatar)!, withInitials: (person?.initials)!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
      
        let cellId = (indexPath.row == 1) ? "PersonInfoViewCell": "EmptyViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellId , for: indexPath)
        
        if (indexPath.row == 1) {
           let personInfoCell = cell as! CMBPersonCollectionViewCell
            personInfoCell.updateView(withPerson: person!)
        }
        return cell
    }
}

extension CMBPersonCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        
        if row == 0 {
            return CGSize(width: view.frame.width, height: view.frame.height/2)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//
//  HomeController.swift
//  YouTube
//
//  Created by Shilpa Bhat on 23/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titlelabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titlelabel.textColor = UIColor.white
        titlelabel.font = UIFont.systemFont(ofSize: 20)
        titlelabel.text = "Home"
        navigationItem.titleView = titlelabel
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setUpMenuBar()
       // setupNavBarButtons()
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithName("H:|[v0]|", views: menuBar)
        view.addConstraintsWithName("V:|[v0(50)]", views: menuBar)
    }
    
//    func setupNavBarButtons() {
//        
//        let searchImage = UIImage(named: "Search_image")?.withRenderingMode(.alwaysTemplate)
//        let searchImage
//    
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = (view.frame.width - 16 - 16) * 9.0 / 16.0
        return CGSize(width: view.frame.width, height: collectionViewHeight)
    }
}

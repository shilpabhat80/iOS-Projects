//
//  HomeDatasourceController.swift
//  Twitter
//
//  Created by Shilpa Bhat on 30/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import LBTAComponents
import TRON

class HomeDatasourceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Error found"
        label.isHidden = true
        return label
    }()
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()
        
        setUpNavigationButtons()
        
        Service.sharedInstance.fetchHomeFeed(completion: { (homedatasource, error) in
            if let err = error {
                self.errorMessageLabel.isHidden = false
                
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Status code was not 200."
                        return
                    }
                }
            }
            self.datasource = homedatasource
        })
    }
    
    private func estimatedLengthForText(_ text: String) -> CGFloat
    {
        let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 8
        let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            if let user = self.datasource?.item(indexPath) as? User {
                
                let estimatedHeight = estimatedLengthForText(user.bioText)
                return CGSize(width: view.frame.size.width, height: estimatedHeight+66)
            }
        }
        else if indexPath.section == 1 {
            guard let tweet = datasource?.item(indexPath) as? Tweet else {
                return .zero
            }
            
            let estimatedHeight = estimatedLengthForText(tweet.message)
            return CGSize(width: view.frame.size.width, height: estimatedHeight+74)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.size.width, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


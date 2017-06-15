//
//  CMBPhotoCacheManager.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 26/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class CMBPhotoCacheManager {
    
    static let shared = CMBPhotoCacheManager()
    private var emptyImage: UIImage = UIImage()
    
    
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    
    let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    let nameInitalsPhotoCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    private var urlStringForChecking: String?
    
    var shouldUseEmptyImage = true
    
    func cachedImageForKey(urlString: String) ->UIImage?
    {
        let urlKey = urlString as NSString
        if let cachedItem = imageCache.object(forKey: urlKey) {
            let image = cachedItem.image
            return image
        }
        return nil
    }
    
    func initialsImage(_ initials: String?) -> UIImage? {
        
        guard let initial = initials else {
            return emptyImage
        }
        guard initial.characters.count > 0 else {
            return emptyImage
        }
        
        let imageSize = CGSize(width: 120.0, height: 120.0)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 50.0),NSForegroundColorAttributeName: UIColor.pantonBlue]
            
            initial.draw(with: CGRect(x: 30, y: 30, width: 120.0, height: 120.0), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        return img
    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */
    
    func loadImage(urlString: String, withInitials initials:String?, completion: ((UIImage?) -> ())? = nil) {
        var image:UIImage?
    
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?(image)
            return
        }
    
        image = initialsImage(initials)
        completion?(image)

        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            if let image = UIImage(data: data!) {
                let cacheItem = DiscardableImageCacheItem(image: image)
                self?.imageCache.setObject(cacheItem, forKey: urlKey)
                
                if urlString == self?.urlStringForChecking {
                    completion?(image)
                }
            }
            
        }).resume()
    }
    
}

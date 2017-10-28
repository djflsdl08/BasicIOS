//
//  ImageStore.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 28..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ImageStore {
    
    // MARK: - Properties
    let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Functions
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}

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
        
        let imageURL = imageURLForKey(key: key)
        
        if let data = UIImageJPEGRepresentation(image, 0.5) { // -> 1 : Highest quality (minimized compression)
            let _ = try? data.write(to: imageURL as URL, options: [.atomic])
        }
        // If you want to save the each image as a PNG, then you should use the UIImagePNGRepresentation method.
    }
    
    func imageURLForKey(key: String) -> NSURL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key) as NSURL
    }
    
    func imageForKey(key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let imageURL = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: imageURL as URL)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
}

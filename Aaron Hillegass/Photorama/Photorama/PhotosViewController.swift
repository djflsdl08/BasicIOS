//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 김예진 on 2017. 10. 31..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos() {
            (PhotosResult) -> Void in
            
            switch PhotosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImage(for: firstPhoto) {
                        (imageResult) -> Void in
                        
                        switch imageResult {
                        case let .Success(image):
                            self.imageView.image = image
                        case let .Failure(error):
                            print("Error downloading image: \(error)")
                        }
                    }
                }
            case let .Failure(error):
                print("Error fetching recent photos: \(error))")
            }
        }
    }
}

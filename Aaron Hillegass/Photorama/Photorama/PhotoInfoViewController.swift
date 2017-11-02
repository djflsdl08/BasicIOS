//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by 김예진 on 2017. 11. 2..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!

    var photo : Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) {
            (result) -> Void in
            
            switch result {
            case let .Success(image):
                OperationQueue.main.addOperation {
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}

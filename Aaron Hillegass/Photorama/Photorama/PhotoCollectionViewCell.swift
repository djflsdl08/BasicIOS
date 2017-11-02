//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by 김예진 on 2017. 11. 2..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {  // It called after a interace file is loaded and an outlet connection is made.
        super.awakeFromNib()
        
        updateWithImage(image: nil)
    }
    
    override func prepareForReuse() {   // It is called just before the cell is reused.
        super.prepareForReuse()
        
        updateWithImage(image: nil)
    }
}

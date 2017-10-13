//
//  ImageViewController.swift
//  Image
//
//  Created by 김예진 on 2017. 10. 13..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL : NSURL? {
        didSet {
            image = nil
            fetchImage()
        }
    }
    
    // create ImageView in the code.
    
    private func fetchImage() {
        if let url = imageURL {
            if let imagedata = NSData(contentsOf : url as URL) {
                image = UIImage(data : imagedata as Data)
            }
        }
    }
    
    private var imageView = UIImageView()

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    private var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView) // view : top of the UIview
        imageURL = NSURL(string : DemoURL.nightView)
    }

}

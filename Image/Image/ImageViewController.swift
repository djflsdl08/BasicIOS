//
//  ImageViewController.swift
//  Image
//
//  Created by 김예진 on 2017. 10. 13..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate {
    
    var imageURL : NSURL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    // create ImageView in the code.
    
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos : .userInitiated).async {
                let contentOfURL = NSData(contentsOf : url as URL)
                DispatchQueue.main.async {
                    if url == self.imageURL {
                        if let imagedata = contentOfURL {
                            self.image = UIImage(data : imagedata as Data)
                        } else {
                            self.spinner?.stopAnimating()
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    
    private var imageView = UIImageView()

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView) // view : top of the UIview
        //imageURL = NSURL(string : DemoURL.nightView)
    }

}

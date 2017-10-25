//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by 김예진 on 2017. 10. 25..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        let url = URL(string : "https://www.bignerdranch.com")
        let request = URLRequest(url : url!)
        webView.loadRequest(request)
    }
}

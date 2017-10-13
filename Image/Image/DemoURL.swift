//
//  DemoURL.swift
//  Image
//
//  Created by 김예진 on 2017. 10. 13..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import Foundation

struct DemoURL {
    static let nightView = "https://cdn.pixabay.com/photo/2016/10/24/22/43/dubai-1767540_960_720.jpg"
    
    static let NASA = [
        "Earth" : "https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/mississippi_oli_2016336_lrg.jpg",
        "Plane" : "https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/afrc2017-0271-13.jpg",
        "Launch" : "https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/9460154150_fa5dfb5909_o.jpg",
        "people" : "https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/s65-46645.jpg"
    ]
    
    static func NASAImageNamed(imageName : String?) -> NSURL? {
        if let urlString = NASA[imageName ?? ""] {
            return NSURL(string : urlString)
        } else {
            return nil
        }
    }
    
}

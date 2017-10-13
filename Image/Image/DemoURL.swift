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
        "Earth" : "https://cdn.pixabay.com/photo/2012/01/09/09/48/earth-11593_960_720.jpg",
        "Spaceship" : "https://cdn.pixabay.com/photo/2017/09/21/08/17/satellite-2771080_960_720.jpg",
        "Launch" : "https://cdn.pixabay.com/photo/2012/11/28/11/28/rocket-launch-67723_960_720.jpg",
        "Astronaut" : "https://cdn.pixabay.com/photo/2012/10/10/10/36/moon-landing-60582_960_720.jpg"
    ]
    
    static func NASAImageNamed(imageName : String?) -> NSURL? {
        if let urlString = NASA[imageName ?? ""] {
            return NSURL(string : urlString)
        } else {
            return nil
        }
    }
    
}

//
//  Photo.swift
//  Photorama
//
//  Created by 김예진 on 2017. 11. 1..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class Photo {
    
    // MARK: - Properties
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    var image: UIImage?
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}

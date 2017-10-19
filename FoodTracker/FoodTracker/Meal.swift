//
//  Meal.swift
//  FoodTracker
//
//  Created by 김예진 on 2017. 10. 18..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit
import os.log

class Meal : NSObject, NSCoding {
    //MARK : Properties
    var name : String
    var photo : UIImage?
    var rating : Int
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK : Archiving Paths
    static let DocumentsDirectory = FileManager().urls(
        for:.documentDirectory,
        in : .userDomainMask
        ).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK : Initialization 
    init?(name : String, photo : UIImage?, rating : Int) {
        /*
        if name.isEmpty || rating < 0 {
            return nil
        }*/
        guard !name.isEmpty else {  // The name must not be empty
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK : NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey : PropertyKey.name)
        aCoder.encode(photo, forKey : PropertyKey.photo)
        aCoder.encode(rating, forKey : PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder : NSCoder) {
        guard let name = aDecoder.decodeObject(forKey : PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object", log : OSLog.default, type : .debug)
            return nil
        }
        
        let photo = aDecoder.decodeObject(forKey:PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey:PropertyKey.rating)
        
        self.init(name : name, photo : photo, rating : rating)
    }
}

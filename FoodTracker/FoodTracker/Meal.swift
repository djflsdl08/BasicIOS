//
//  Meal.swift
//  FoodTracker
//
//  Created by 김예진 on 2017. 10. 18..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class Meal {
    //MARK : Properties
    var name : String
    var photo : UIImage?
    var rating : Int
    
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
}

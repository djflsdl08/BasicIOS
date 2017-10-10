//
//  FacialExpression.swift
//  FaceIt
//
//  Created by 김예진 on 2017. 10. 9..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import Foundation

struct FacialExpression {
    enum Eyes : Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows : Int {
        case Relaxed
        case Normal
        case Furrowed
        
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue : rawValue + 1) ?? .Furrowed
        }
        
        func moreRelaxedBrow() -> EyeBrows {
            return EyeBrows(rawValue : rawValue - 1) ?? .Relaxed
        }
    }
    
    enum Mouth : Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func happierMouth() -> Mouth {
            return Mouth(rawValue : rawValue + 1) ?? .Smile
        }
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue : rawValue - 1) ?? .Frown
        }
    }
    
    var eyes : Eyes
    var eyeBrows : EyeBrows
    var mouth : Mouth
}

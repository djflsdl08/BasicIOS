//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by 김예진 on 2017. 10. 11..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces : Dictionary <String,FacialExpression> = [
        "angry" : FacialExpression(eyes : .Closed, eyeBrows : .Furrowed, mouth : .Frown),
        "mischievious" : FacialExpression(eyes : .Open, eyeBrows : .Furrowed, mouth : .Grin),
        "worried" : FacialExpression(eyes : .Open, eyeBrows : .Relaxed, mouth : .Smirk),
        "happy" : FacialExpression(eyes : .Open, eyeBrows : .Normal, mouth : .Smile)
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        
        if let navcon = destinationVC as? UINavigationController {
            destinationVC = navcon.visibleViewController ?? destinationVC
        }
        
        if let faceVC = destinationVC as? FaceViewController {
            if let identifier = segue.identifier {
                faceVC.expression = emotionalFaces[identifier]!
                if let sendingButton = sender as? UIButton {
                    faceVC.navigationItem.title = sendingButton.currentTitle
                }
            }
        }
        
    }

}

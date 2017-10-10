//
//  ViewController.swift
//  FaceIt
//
//  Created by 김예진 on 2017. 10. 9..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    var expression = FacialExpression(eyes : .Open, eyeBrows : .Normal, mouth : .Neutral) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(
                UIPinchGestureRecognizer(
                    target : faceView,
                    action : #selector(FaceView.changeScale(recognizer:))
                )
            )
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target : self,
                action : #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                    target : self,
                    action : #selector(FaceViewController.decreaseHappiness)
                )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch expression.eyes {
            case .Open : expression.eyes = .Closed
            case .Closed : expression.eyes = .Open
            case .Squinting : break
            }
        }
    }
    
    var mouthCurvatures = [FacialExpression.Mouth.Frown : -1.0, .Grin : 0.5, .Smile : 1.0, .Smirk : -0.5, .Neutral : 0.0]
    
    var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed : 0.5, .Normal : 0.0, .Furrowed : -0.5]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open : faceView.eyesOpen = true
        case .Closed : faceView.eyesOpen = false
        case .Squinting : faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}


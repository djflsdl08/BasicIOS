//
//  DropItViewController.swift
//  DropIt
//
//  Created by 김예진 on 2017. 10. 16..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController {

    @IBOutlet weak var gameView: DropItView! {
        didSet {
            gameView.addGestureRecognizer(UITapGestureRecognizer(target : self, action : #selector(addDrop(recognizer:))))
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target : gameView, action : #selector(DropItView.grabDrop(recognizer:))))
        }
    }
    
    func addDrop(recognizer : UITapGestureRecognizer) {
        if recognizer.state == .ended {
            gameView.addDrop()
        }
    }
    
    override func viewDidAppear(_ animated : Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        gameView.animating = false
    }
}

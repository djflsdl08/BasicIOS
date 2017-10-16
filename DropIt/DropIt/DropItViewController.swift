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
        }
    }
    
    func addDrop(recognizer : UITapGestureRecognizer) {
        if recognizer.state == .ended {
            gameView.addDrop()
        }
    }
}

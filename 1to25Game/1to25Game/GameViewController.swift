//
//  GameViewController.swift
//  1to25Game
//
//  Created by 김예진 on 2017. 10. 23..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK : Properties
    @IBOutlet weak var pressToStart: UIButton!
    @IBOutlet weak var highestScore: UILabel!
    @IBOutlet weak var currentRecord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions.
    
    @IBAction func DisappearTheCover(_ sender: UIButton) {
        pressToStart.removeFromSuperview()
    }
}

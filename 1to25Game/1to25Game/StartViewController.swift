//
//  StartViewController.swift
//  1to25Game
//
//  Created by 김예진 on 2017. 10. 23..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

   
    @IBOutlet weak var gameTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            self.gameTitle.center = CGPoint(x:200,y:80)
        }, completion: nil)
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

}

//
//  HistoryViewController.swift
//  1to25Game
//
//  Created by 김예진 on 2017. 10. 23..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    
    // MARK: Actions
    
    @IBAction func CloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

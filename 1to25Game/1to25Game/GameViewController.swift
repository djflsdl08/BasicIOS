//
//  GameViewController.swift
//  1to25Game
//
//  Created by 김예진 on 2017. 10. 23..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK : - Properties
    @IBOutlet weak var pressToStart: UIButton!
    @IBOutlet weak var highestScore: UILabel!
    @IBOutlet weak var currentRecord: UILabel!
    
    var timer = Timer()
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        timer.invalidate()
    }
    
    
    //MARK: - Actions
    @IBAction func DisappearTheCover(_ sender: UIButton) {
        pressToStart.removeFromSuperview()
        runTimer()
    }
    
    func currentRecordFormat(time: TimeInterval) -> String {
        
        let date = NSDate(timeIntervalSince1970: Double(time))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: date as Date)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        seconds += 1
        currentRecord.text = currentRecordFormat(time: TimeInterval(seconds))
    }
}

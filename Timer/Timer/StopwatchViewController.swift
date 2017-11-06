//
//  StopwatchViewController.swift
//  Timer
//
//  Created by 김예진 on 2017. 11. 3..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapResetButton: UIButton!
    
    var timer = Timer()
    var isTimerRunning = false
    var seconds = 0
    
    @IBAction func startStopButton(_ sender: UIButton) {
        lapResetButton.isEnabled = true
        
        if sender.currentTitle == "Start" {
            runTimer()
            sender.setTitle("Stop", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            lapResetButton.setTitle("Lap", for: .normal)
        } else if sender.currentTitle == "Stop" {
            timer.invalidate()
            sender.setTitle("Start", for: .normal)
            sender.setTitleColor(.green, for: .normal)
            lapResetButton.setTitle("Reset", for: .normal)
        }
    }
    
    @IBAction func lapResetButton(_ sender: UIButton) {
        if sender.currentTitle == "Lap" {
            
        } else if sender.currentTitle == "Reset" {
            timer.invalidate()
            seconds = 0
            timerLabel.text = timerLabelFormat(time: TimeInterval(seconds))
            lapResetButton.isEnabled = false
            lapResetButton.setTitle("Lap", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapResetButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func timerLabelFormat(time: TimeInterval) -> String {
        
        let date = NSDate(timeIntervalSince1970: Double(time))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        formatter.dateFormat = "mm:ss"
        
        return formatter.string(from: date as Date)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(StopwatchViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        seconds += 1
        timerLabel.text = timerLabelFormat(time: TimeInterval(seconds))
    }
}

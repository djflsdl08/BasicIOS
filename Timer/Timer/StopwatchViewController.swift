//
//  StopwatchViewController.swift
//  Timer
//
//  Created by 김예진 on 2017. 11. 3..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var timer = Timer()
    //var isTimerRunning = false
    var seconds = 0
    var lapSeconds = 0
    var lapCell : [LapTableViewCell] = []
    var lapCount = 0
    
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
            lapCount += 1
            let time = timerLabelFormat(time: TimeInterval(lapSeconds))
            let lapLabel = "Lap" + "\(lapCount)"
            let newLapCell = LapTableViewCell()
            newLapCell.time.text = time
            newLapCell.lapCount.text = lapLabel
            
            lapCell.append(newLapCell)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            lapSeconds = 0
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
        tableView.delegate = self
        tableView.dataSource = self
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
        lapSeconds += 1
        timerLabel.text = timerLabelFormat(time: TimeInterval(seconds))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let row = indexPath.row
        
        cell?.textLabel?.text = lapCell[row].time.text
        
        return cell!
    }
}

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
    var lapCount = 0
    var lapDatas = [lapData]()
    
    var compareTime = ["min":Int.max,"max":Int.min,"minIndex":0,"maxIndex":0]
    
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
            findMinMax(index : lapCount)
            lapCount += 1
            let time = timerLabelFormat(time: TimeInterval(lapSeconds))
            let newLap = lapData(lapTime: time, lapCount: lapCount)
            
            lapDatas.append(newLap)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            lapSeconds = 0
        } else if sender.currentTitle == "Reset" {
            timer.invalidate()
            seconds = 0
            lapSeconds = 0
            lapCount = 0
            timerLabel.text = timerLabelFormat(time: TimeInterval(seconds))
            lapResetButton.isEnabled = false
            lapResetButton.setTitle("Lap", for: .normal)
            lapDatas.removeAll()
            compareTimeInit()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    func compareTimeInit() {
        compareTime["min"] = Int.max
        compareTime["max"] = Int.min
        compareTime["minIndex"] = 0
        compareTime["maxIndex"] = 0
    }
    
    func findMinMax(index : Int) {
        if lapSeconds < compareTime["min"]! {
            compareTime["min"] = lapSeconds
            compareTime["minIndex"] = index
        } else if lapSeconds > compareTime["max"]! {
            compareTime["max"] = lapSeconds
            compareTime["maxIndex"] = index
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapResetButton.isEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
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
        tableView.backgroundColor = UIColor.black
        return lapDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
        
        let cellIdentifier = "cell"
        
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: cellIdentifier,
            for: indexPath
            ) as? LapTableViewCell else {
                fatalError("The dequeued cell is not an instance of LapTableViewCell.")
        }
        
        let data = lapDatas[indexPath.row]
       
        //print("indexPath.row : \(indexPath.row)")
        //print("minIndex : \(Int(compareTime["minIndex"]!))")
        //print("maxIndex : \(Int(compareTime["maxIndex"]!))")
        //print("-------------------------")
        
        cell.lapCount.textColor = UIColor.white
        cell.time.textColor = UIColor.white
        
        if indexPath.row == Int(compareTime["minIndex"]!) {
            cell.lapCount.textColor = UIColor.green
            cell.time.textColor = UIColor.green
        } else if indexPath.row == Int(compareTime["maxIndex"]!) {
            cell.lapCount.textColor = UIColor.red
            cell.time.textColor = UIColor.red
        }
        
        cell.lapCount.text = "Lap \(data.lapCount)"
        cell.time.text = data.lapTime
        
        return cell
    }
}

//
//  TimerViewController.swift
//  Timer
//
//  Created by 김예진 on 2017. 11. 3..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var selectTime: UIPickerView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var start: UIButton!
    @IBOutlet var timerLabel: UILabel!
    
    var hours = [String]()
    var minutes = [String]()
    var seconds = [String]()
    
    var hour : Int = 0
    var minute : Int = 0
    var second : Int = 0
    
    var timer = Timer()
    var convertedSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectTime.delegate = self
        self.selectTime.dataSource = self
        
        cancel.isEnabled = false
        timerLabel.removeFromSuperview()
        
        for i in 0..<24 {
            hours.append("\(i)")
        }
        
        for i in 0..<60 {
            minutes.append("\(i)")
            seconds.append("\(i)")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0 : return hours.count
        case 1 : return minutes.count
        case 2 : return seconds.count
        default : return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        var integer = ""
        
        switch(component) {
        case 0 : integer = hours[row]
        case 1 : integer = minutes[row]
        case 2 : integer = seconds[row]
        default : break
        }
        
        let attributedString = NSAttributedString(string: integer, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component) {
        case 0 :
            hour = row
        case 1 :
            minute = row
        case 2 :
            second = row
        default : break
        }
        convertedSeconds = hour*60*60 + minute*60 + second
    }
    
    @IBAction func startPauseResumeButton(_ sender: UIButton) {
        cancel.isEnabled = true
        
        if sender.currentTitle == "Start" {
            sender.setTitle("Pause", for: .normal)
            sender.setTitleColor(UIColor.orange, for: .normal)
            selectTime.removeFromSuperview()
            timerLabel.text = timerLabelFormat(time: TimeInterval(convertedSeconds))
            selectedTime()
            
        }
        else if sender.currentTitle == "Pause" {
            sender.setTitle("Resume", for: .normal)
            sender.setTitleColor(UIColor.green, for: .normal)
        }
        else if sender.currentTitle == "Resume" {
            sender.setTitle("Pause", for: .normal)
            sender.setTitleColor(UIColor.orange, for: .normal)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        cancel.isEnabled = false
        start.setTitle("Start", for: .normal)
        start.setTitleColor(UIColor.green, for: .normal)
        
        convertedSeconds = 0
        timer.invalidate()
        
        timerLabel.removeFromSuperview()
        view.insertSubview(selectTime, at: 0)
        
        
    }
    
    func timerLabelFormat(time: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: Double(time))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: date as Date)
    }
    
    func selectedTime() {
        
        view.insertSubview(timerLabel, at: 0)
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        convertedSeconds -= 1
        timerLabel.text = timerLabelFormat(time: TimeInterval(convertedSeconds))
        
        if convertedSeconds == 0 {
            timer.invalidate()
            let alert = UIAlertController(title: "CLOCK", message: "Timer Done", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler : {
                    action -> Void in
                    self.timerLabel.removeFromSuperview()
                    self.view.insertSubview(self.selectTime, at: 0)
                }
            ))
            present(alert, animated: true, completion: nil)
        }
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

//
//  TimerViewController.swift
//  Timer
//
//  Created by 김예진 on 2017. 11. 3..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectTime: UIPickerView!
    var hours = [String]()
    var minutes = [String]()
    var seconds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectTime.delegate = self
        self.selectTime.dataSource = self
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

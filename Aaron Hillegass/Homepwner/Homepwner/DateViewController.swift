//
//  DateViewController.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 28..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    var item : Item!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.datePickerMode = .date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date as NSDate
    }

}

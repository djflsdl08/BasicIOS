//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by 김예진 on 2017. 10. 25..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    //MARK : Properties
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print("ConversionViewController loaded its view.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let date = NSDate()
        let current = Calendar.current
        let hour = current.component(.hour, from: date as Date)
        
        // print(hour) -> 0 ~ 24
        
        if hour >= 6 && hour < 18 { // Day
            view.backgroundColor = UIColor(red: 254/255, green: 253/255, blue: 137/255, alpha: 1.0)
        } else {    // night
            view.backgroundColor = UIColor(red: 101/255, green: 100/255, blue: 125/255, alpha: 1.0)
        }
    }
    
    var fahrenheitValue : Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue : Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            //celsiusLabel.text = "\(value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value : value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField : UITextField,
                   shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        /*
        print("Current text : \(textField.text)")
        print("Replacement text : \(string)")
        */
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        var dataSet = NSCharacterSet.decimalDigits
        dataSet.insert(charactersIn: ".")
        
        let inputTextIsNumber = string.rangeOfCharacter(from: dataSet)
        // inputTextIsNumber = nil -> If the user enters an alphabet
        
        if inputTextIsNumber != nil || string.isEmpty {
            if existingTextHasDecimalSeparator != nil &&
                replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    //MARK : Actions
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        /*
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = textField.text
        } else {
            celsiusLabel.text = "???"
        }
        */
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
}

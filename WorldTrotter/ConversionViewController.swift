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
        
        
        if existingTextHasDecimalSeparator != nil &&
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
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

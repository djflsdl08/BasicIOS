//
//  ViewController.swift
//  Cal
//
//  Created by 김예진 on 2017. 9. 24..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var arithmaticOperation = false
    private var rememberOperation : String?
    
    @IBAction private func TouchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //print("touched \(digit) ")
        arithmaticOperation = false
        if rememberOperation != nil {
            brain.performOperation(symbol : rememberOperation!)
            rememberOperation = nil
        }
        if userIsInTheMiddleOfTyping {
            display.text! += digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
 
    @IBAction private func Operation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand:displayValue)
        }
        
        userIsInTheMiddleOfTyping = false
        if let currentOperation = sender.currentTitle {
            switch currentOperation {
            case "+","−","×","÷" :
                arithmaticOperation = true
                rememberOperation = currentOperation
            default : brain.performOperation(symbol : currentOperation)
            }
        }
        if (arithmaticOperation == false) {
            displayValue = brain.result
        }
    }
}

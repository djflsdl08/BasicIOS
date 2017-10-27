//
//  userTextField.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 28..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class userTextField: UITextField {

    // Not working
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        self.borderStyle = .line
        return true
    }

    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.borderStyle = .bezel
        return true
    }
}

//
//  LoginViewController.swift
//  LoginSystem
//
//  Created by 김예진 on 2017. 10. 20..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // Using keychain, protect the security.
    
    @IBOutlet weak var Id: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Id.delegate = self
        Password.delegate = self
    }

    @IBAction func SignIn(_ sender: UIButton) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

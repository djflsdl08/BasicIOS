//
//  SignUpViewController.swift
//  LoginSystem
//
//  Created by 김예진 on 2017. 10. 21..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Id.delegate = self
        password.delegate = self
        checkPassword.delegate = self
        textView.delegate = self
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if let id = Id.text, let password = password.text,
            let checkPassword = checkPassword.text {

            if(id.isEmpty || password.isEmpty || checkPassword.isEmpty) {
                var artMsg = "Input the "
                
                if(id.isEmpty) {
                    artMsg += "ID"
                } else if(password.isEmpty) {
                    artMsg += "Password"
                } else if(checkPassword.isEmpty) {
                    artMsg += "check Password"
                }
                
                let alert = UIAlertController(title: "Fail to signup", message: artMsg, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if password == checkPassword {
                dismiss(animated: true, completion: nil)
            } else {
                let checkPasswordAlert = UIAlertController(title: "Password do not match", message : "Check your password", preferredStyle : UIAlertControllerStyle.alert)
                checkPasswordAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(checkPasswordAlert, animated: true, completion : nil)
                return
            }
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK : Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        hideTheKeyboard()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK : UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.view.endEditing(true)
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: When user clicks the background, keyboard will be disappear.
    @IBAction func background(_ sender: UITapGestureRecognizer) {
        hideTheKeyboard()
    }
    
    func hideTheKeyboard() {
        Id.resignFirstResponder()
        password.resignFirstResponder()
        checkPassword.resignFirstResponder()
        textView.resignFirstResponder()
    }
}

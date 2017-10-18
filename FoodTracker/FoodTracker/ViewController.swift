//
//  ViewController.swift
//  FoodTracker
//
//  Created by 김예진 on 2017. 10. 17..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK : Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phtoImageView: UIImageView!
    @IBOutlet weak var RatingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }

    //MARK : UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    //MARK : Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()    // Hide keyboard
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK : UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated : true, completion : nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        phtoImageView.image = selectedImage
        dismiss(animated : true, completion : nil)
    }
}


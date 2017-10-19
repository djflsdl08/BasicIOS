//
//  MealViewController.swift
//  FoodTracker
//
//  Created by 김예진 on 2017. 10. 17..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK : Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phtoImageView: UIImageView!
    @IBOutlet weak var RatingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            phtoImageView.image = meal.photo
            RatingControl.rating = meal.rating
        }
        
        updateSaveButtonState()
    }

    //MARK : UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller")
        }
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender: Any?) {
        // This method lets you configure a view controller before it's presented.
        super.prepare(for: segue, sender : sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log : OSLog.default, type : .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = phtoImageView.image
        let rating = RatingControl.rating
        
        meal = Meal(name : name, photo : photo, rating : rating)
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
    
    //MARK: Private methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}


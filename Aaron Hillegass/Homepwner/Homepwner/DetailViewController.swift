//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 27..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate,
                        UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: - Properties
    @IBOutlet var nameField: userTextField!
    @IBOutlet var serialNumberField: userTextField!
    @IBOutlet var valueField: userTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Actions
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        // Check the textField which is first responder,
        // and then call the resignFirstResponder() of specific view.
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        // If the divice has a camera, take a picture. if not, select a photo from your photo library.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        // UIImagePickerController has cameraOverlayView property.
        present(imagePicker,animated: true, completion: nil)
    }
    
    @IBAction func removeImage(_ sender: UIButton) {
        if imageView.image == nil {
            let alert = UIAlertController (
                title: "Information",
                message: "This item doesn't have image.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction (
                title: "OK",
                style: UIAlertActionStyle.default
            )
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            let actionSheet = UIAlertController (
                title: "Remeve Image",
                message : "Are you sure you want to remove this image?",
                preferredStyle: .actionSheet
            )
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
            actionSheet.addAction(cancelAction)
            
            let removeAction = UIAlertAction(
                title: "Remove",
                style: .destructive,
                handler: {
                    action -> Void in
                    self.imageStore.deleteImageForKey(key: self.item.itemKey)
                    self.imageView.image = nil
                    self.item.itemKey = ""
            }
            )
            actionSheet.addAction(removeAction)
            present(actionSheet, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the selected image from dictionary.
        //let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let image = info[UIImagePickerControllerEditedImage] as! UIImage

        imageStore.setImage(image: image, forKey: item.itemKey)
        
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - view life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        //valueField.text = "\(item.valueInDollars)"
        //dateLabel.text = "\(item.dateCreated)"
        valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
        let key = item.itemKey
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDatePicker" {
            let destination = segue.destination as! DateViewController
            destination.item = item
        }
    }
}

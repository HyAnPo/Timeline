//
//  AddPhotoTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class AddPhotoTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    var image: UIImage?
    var caption: String?
    
    // MARK: - Outlets
    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var postButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func addPhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            alert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) in
                imagePicker.sourceType = .Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func postButtonTapped() {
    
        if let image = self.image {
            PostController.addPost(image, caption: self.caption, completion: { (success, post) in
                if post != nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        } else {
            let failedAlert = UIAlertController(title: "ERROR", message: "OOPS it seems there was a problem selecting an image, please try again.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            failedAlert.addAction(action)
            presentViewController(failedAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - Extensions

extension AddPhotoTableViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            self.image = image
            postButton.setTitle("", forState: .Normal)
            postButton.setBackgroundImage(image, forState: .Normal)
        }
    }
}

extension AddPhotoTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let text = textField.text {
            self.caption = text
        }
        
        textField.resignFirstResponder()
        return true
    }
}
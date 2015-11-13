//
//  AddPhotoTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class AddPhotoTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var image: UIImage?
    var caption: String?
    
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Buttons
    
    @IBAction func addPhotoButtonTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let photoChoiceAlet = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
            photoChoiceAlet.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            photoChoiceAlet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .Camera
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        photoChoiceAlet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(photoChoiceAlet, animated: true, completion: nil)
        
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        
    }

    
    // MARK: - Image Picker Controller Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        photoButton.setBackgroundImage(image, forState: .Normal)
        photoButton.setTitle(nil, forState: .Normal)
    }

}

extension AddPhotoTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        caption = textField.text
        textField.resignFirstResponder()
        return true
    }
}

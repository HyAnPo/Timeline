//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!

    enum ViewMode {
        case Login
        case Signup
        
    }
    
    var viewMode = ViewMode.Signup
    
    //MARK: Bug
    func updateViewBasedOnMode() {
        switch viewMode {
        case .Login:
            usernameTextField.removeFromSuperview()
            bioTextField.removeFromSuperview()
            urlTextField.removeFromSuperview()
           
            actionButton.setTitle("Login", forState: .Normal)
        case .Signup:
            actionButton.setTitle("Sign Up", forState: .Normal)
            
        }
    }
    
    var fieldsAreValid: Bool {
        get {
            switch viewMode {
            case .Login:
                return !(usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Signup:
                return !(emailTextField.text!.isEmpty || usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()

    }

    @IBAction func actionButtonTapped(sender: UIButton) {
        
        if fieldsAreValid {
            switch viewMode {
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text! , completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable To Login", message: "Please check your information and try again.")
                    }
                })
            case .Signup:
                UserController.createUser(emailTextField.text!, userName: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: urlTextField.text, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Signup", message: "Check your information and try again.")
                    }
                })
            }
        }
    }
    
    func presentValidationAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
   
}





























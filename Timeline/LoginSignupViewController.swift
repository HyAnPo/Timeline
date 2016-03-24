//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {
    
    // MARK: - Enum
    enum ViewMode {
        case Login
        case Signup
    }
    
    // MARK: - Outlets
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var bioTextField: UITextField!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var actionButton: UIButton!
    
    // MARK: - Properties
    var mode: ViewMode = .Signup
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Signup:
                return !(usernameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Login:
                return !(usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode(mode)
        
        if !fieldsAreValid {
            actionButton.enabled = false
        }
    }

    
    
    // MARK: - Buttons
    @IBAction func actionButtonTapped(sender: UIButton) {
        
        if fieldsAreValid {
            switch mode {
            case .Signup:
                UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: urlTextField.text, completion: { (success, user) in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Oh Crap!", message: "Failed to create user")
                    }
                })
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Oh Crap!", message: "Failed to login, check email and password.")
                    }
                })
            }
        }
    }
    
    // MARK: - Functions
    func updateViewBasedOnMode(mode: ViewMode) {
        switch mode {
        case .Signup:
            actionButton.setTitle("Signup", forState: .Normal)
        case .Login:
            emailTextField.removeFromSuperview()
            bioTextField.hidden = true
            urlTextField.hidden = true
            actionButton.setTitle("Login", forState: .Normal)
        }
    }
    
    func presentValidationAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Try Again", style: .Default, handler: nil)
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

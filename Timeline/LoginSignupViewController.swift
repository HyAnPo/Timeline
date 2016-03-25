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
        case Edit
    }
    
    // MARK: - Outlets
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var bioTextField: UITextField!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var actionButton: UIButton!
    
    // MARK: - Properties
    var viewMode: ViewMode = .Signup
    var fieldsAreValid: Bool {
        get {
            switch viewMode {
            case .Signup:
                return !(usernameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Login:
                return !(usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Edit:
                return !(usernameTextField.text!.isEmpty)
            }
        }
    }
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode(viewMode)
        
        if let user = user {
            updateWithUser(user)
        }
    }
    
    
    // MARK: - Buttons
    @IBAction func actionButtonTapped(sender: UIButton) {
        
        if fieldsAreValid {
            switch viewMode {
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
            case .Edit:
                if let user = user {
                    UserController.updateUser(user, username: usernameTextField.text!, bio: bioTextField.text, url: urlTextField.text, completion: { (success, user) in
                        if success {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            self.presentValidationAlertWithTitle("Failed to Update User", message: "Please check your information and try again.")
                        }
                    })
                }
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
        case .Edit:
            emailTextField.hidden = true
            passwordTextField.hidden = true
            actionButton.setTitle("Save", forState: .Normal)
        }
    }
    
    func updateWithUser(user: User) {
        self.user = user
        viewMode = .Edit
    }
    
    func presentValidationAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Try Again", style: .Default, handler: nil)
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

//
//  LoginSignupPickerViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class LoginSignupPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toSignup" {
            let destinationViewController = segue.destinationViewController as? LoginSignupViewController
            destinationViewController?.viewMode = LoginSignupViewController.ViewMode.Signup
        } else if segue.identifier == "toLogin" {
            let destinationViewController = segue.destinationViewController as? LoginSignupViewController
            destinationViewController?.viewMode = LoginSignupViewController.ViewMode.Login
        }
    }

}

//
//  LoginSignupChoiceViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class LoginSignupChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSignup" {
            if let destinationViewController = segue.destinationViewController as? LoginSignupViewController {
                destinationViewController.mode = LoginSignupViewController.ViewMode.Signup
            }
        } else if segue.identifier == "toLogin" {
            if let destinationViewController = segue.destinationViewController as? LoginSignupViewController {
                destinationViewController.mode = LoginSignupViewController.ViewMode.Login
            }
        }
    }
    
}

//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let currentUser = UserController.sharedController.currentUser {
            if posts.count > 0 {
                loadPostsForUser(currentUser)
            } else {
                tabBarController?.performSegueWithIdentifier("toLoginSignup", sender: nil)
            }
        }
    }
    
    func loadPostsForUser(user: User) {
        PostController.fetchTimelineForUser(user) { (posts) in
            self.posts = posts
        }
    }

}

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
            }
        } else {
            tabBarController?.performSegueWithIdentifier("toLoginSignup", sender: nil)
        }
    }
    
    func loadPostsForUser(user: User) {
        PostController.fetchTimelineForUser(user) { (posts) in
            self.posts = posts
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
        }
    }
    
    // MARK: - Actions
    @IBAction func userRefreshedTable() {
        loadPostsForUser(UserController.sharedController.currentUser)
    }
    
    // MARK: - TableView Data Source methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as? PostTableViewCell {
            let post = posts[indexPath.row]
            cell.updateWithPost(post)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPostDetail" {
            if let destinationView = segue.destinationViewController as? PostDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow {
                let post = posts[indexPath.row]
                destinationView.post = post
            }
        } 
    }

}

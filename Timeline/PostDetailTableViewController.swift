//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {

    // MARK: - Properties
    var post: Post?
    
    // MARK: - Outlets
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateBasedOnPost()
    }
    
    // MARK: - TableView Data Source methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let post = post {
            return post.comments.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        if let post = post {
            let comment = post.comments[indexPath.row]
            
            cell.textLabel?.text = comment.username
            cell.detailTextLabel?.text = comment.text
            
            return cell
        } else {
            return cell
        }
    }
    
    // MARK: - Functions
    func updateBasedOnPost() {
        if let post = post {
            likesLabel.text = "\(post.likes.count) 👍🏼"
            commentsLabel.text = "\(post.comments.count) 💭"
            
            ImageController.imageForIdentifier(post.imageEndPoint, completion: { (image) in
                self.headerImageView.image = image
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
            })
        }
    }
    
    // MARK: - Actions
    @IBAction func likeButtonTapped() {
        if let post = post {
            PostController.addLikeToPost(post, completion: { (success, post) in
                if let post = post {
                    self.post = post
                    self.updateBasedOnPost()
                }
            })
        }
    }
    
    @IBAction func addCommentButtonTapped() {
        if let post = post {
            let commentAlert = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
            commentAlert.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = "Add Comment"
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let submitAction = UIAlertAction(title: "Submit", style: .Default) { (action) in
                if let text = commentAlert.textFields?.first?.text {
                    PostController.addCommentWithTextToPost(text, post: post, completion: { (success, post) in
                        if let post = post {
                            self.post = post
                            self.updateBasedOnPost()
                        }
                    })
                }
            }
            
            commentAlert.addAction(cancelAction)
            commentAlert.addAction(submitAction)
            
            presentViewController(commentAlert, animated: true, completion: nil)
        }
    }
    
    
}





















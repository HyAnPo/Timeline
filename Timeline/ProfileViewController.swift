//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    // MARK: - Properties
    var user: User?
    var userPosts: [Post] = []
    
    
    
    // MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var editBarButtonItem: UIBarButtonItem!

    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.user == nil {
            self.user = UserController.sharedController.currentUser
            editBarButtonItem.enabled = true
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        UserController.userForIdentifier(user!.uid!) { (user) in
//            self.user = user
//            self.updateBasedOnUser()
//        }
    }
    
    func updateBasedOnUser() {
        guard let user = user else { return }
        
        title = user.username
        
        PostController.postsForUser(user) { (posts) in
            if let posts = posts {
                self.userPosts = posts
            } else {
                self.userPosts = []
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
                //self.collectionView.reloadData()
            })
        }
    }
    
    
    
    // MARK: - CollectionView Data Source methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
            let post = userPosts[indexPath.item]
            
            cell.updateWithImageIdentifier(post.imageEndPoint)
            return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerReusableView", forIndexPath: indexPath) as? ProfileHeaderCollectionReusableView, user = user {
            headerView.updateWithUser(user)
            headerView.delegate = self
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditProfile" {
            if let destinationViewController = segue.destinationViewController as? LoginSignupViewController, user = self.user {
                destinationViewController.user = user
                destinationViewController.viewMode = LoginSignupViewController.ViewMode.Edit
            }
        } else if segue.identifier == "toPostDetail" {
            if let cell = sender as? UICollectionViewCell, indexPath = collectionView.indexPathForCell(cell), destinationView = segue.destinationViewController as? PostDetailTableViewController {
                let post = userPosts[indexPath.item]
                destinationView.post = post
            }
        }
    }
}



extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    
    func userTappedURLButton() {
        guard let user = user, urlString = user.url, url = NSURL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(URL: url)
        presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        
        if user == UserController.sharedController.currentUser {
            UserController.logoutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, checkUser: user, completion: { (follows) in
                if follows {
                    UserController.unfollowUser(user, completion: { (success) in
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.updateBasedOnUser()
                        })
                    })
                } else {
                    UserController.followUser(user, completion: { (success) in
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.updateBasedOnUser()
                        })
                    })
                }
            })
        }
    }
}


















//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Andrew Porter on 3/25/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    
    func userTappedFollowActionButton()
    func userTappedURLButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    // MARK: - Outlets
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var urlButton: UIButton!
    @IBOutlet var followButton: UIButton!
    
    
    
    // MARK: - Actions
    @IBAction func urlButtonTapped() {
        delegate?.userTappedURLButton()
    }
    
    @IBAction func followActionButtonTapped() {
            delegate?.userTappedFollowActionButton()
    }
    
    
    
    // MARK: - Functions
    func updateWithUser(user: User) {
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.hidden = true
        }
        
        if let url = user.url {
            urlButton.setTitle(url, forState: .Normal)
        } else {
            urlButton.hidden = true
        }
        
        if user == UserController.sharedController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
            followButton.backgroundColor = UIColor.redColor()
            followButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, checkUser: user, completion: { (follows) in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
    
}

//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Andrew Porter on 11/7/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    
    func userTappedfollowActionButton()
    func userTappedURLButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var followUserButton: UIButton!
    @IBOutlet weak var bioLabel: UITextField!
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    func updateWithUser(user: User) {
        
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.removeFromSuperview()
        }
        
        if let url = user.url {
            urlButton.setTitle(url, forState: .Normal)
        } else {
            urlButton.removeFromSuperview()
        }
        
        if user == UserController.sharedController.currentUser {
            followUserButton.setTitle("Logout", forState: .Normal)
            followUserButton.tintColor = UIColor.redColor()
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, userCheck: user, completion: { (follows) -> Void in
                if follows {
                    self.followUserButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followUserButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
    
    @IBAction func followActionButtonTapped(sender: UIButton) {
        delegate?.userTappedfollowActionButton()
    }
    
    @IBAction func urlButtonTapped(sender: UIButton) {
        delegate?.userTappedURLButton()
    }
    
}


















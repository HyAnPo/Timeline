//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Andrew Porter on 4/12/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    func updateWithPost(post: Post) {
        likesLabel.text = "\(post.likes.count)👍🏼"
        commentsLabel.text = "\(post.comments.count)💭"
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) in
            if let image = image {
                self.postImageView.image = image
            }
        }
        
    }

}

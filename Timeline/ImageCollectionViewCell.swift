//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Andrew Porter on 11/8/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithImageIdentifier(identifier: String) {
        
        ImageController.imageForIdentifier(identifier) { (image) -> Void in
            self.imageView.image = image
        }
    }
}

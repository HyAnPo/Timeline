//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Andrew Porter on 3/25/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet var cellImageView: UIImageView!
    
    
    
    // MARK: - Functions
    func updateWithImageIdentifier(identifier: String) {
        ImageController.imageForIdentifier(identifier) { (image) in
            self.cellImageView.image = image
        }
    }
}

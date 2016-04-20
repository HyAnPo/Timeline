//
//  ImageController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/19/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class ImageController {
    
    static func uploadImage(image: UIImage, completion: (identifier: String?) -> Void) {
        
        completion(identifier: "-K1l4125TYvKMc7rcp5e")
    }
    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        
        completion(image: UIImage(named: "MockPhoto"))
    }
    
    
}
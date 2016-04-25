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
        
        if let imageString = image.base64String {
            let imageFirebaseRef = FirebaseController.base.childByAppendingPath("images")
            
            imageFirebaseRef.setValue(imageString)
            
            completion(identifier: imageFirebaseRef.key)
        } else {
            completion(identifier: nil)
        }
    }
    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        
        FirebaseController.dataAtEndpoint("images/\(identifier)") { (data) in
            
            if let imageString = data as? String {
                let image = UIImage(base64: imageString)
                
                completion(image: image)
            } else {
                completion(image: nil)
            }
        }
    }
    
    
}

extension UIImage {
    var base64String: String? {
        
        guard let data = UIImageJPEGRepresentation(self, 1.0) else { return nil }
        
        return data.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
    }
    
    convenience init?(base64: String) {
        if let imageData = NSData(base64EncodedString: base64, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters) {
            self.init(data: imageData)
        } else {
            return nil
        }
    }
}
//
//  Post.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

struct Post: Equatable {
    
    let imageEndPoint: String
    let caption: String?
    let userName: String
    let comments: [Comment]
    let likes: [Like]
    let identifier: String?
    
    init(imageEndPoint: String, caption: String? = nil, userName: String, comments: [Comment] = [], likes: [Like] = [], identifier: String? = nil) {
        
        self.imageEndPoint = imageEndPoint
        self.caption = caption
        self.userName = userName
        self.comments = comments
        self.likes = likes
        self.identifier = identifier
    }
}

func ==(lhs: Post, rhs: Post) -> Bool {
    
    return (lhs.userName == rhs.userName) && (lhs.identifier == rhs.identifier)
}
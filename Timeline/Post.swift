//
//  Post.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Post: Equatable {
    
    let imageEndPoint: String
    let caption: String?
    let username: String
    let comments: [Comment]
    let likes: [Like]
    let uid: String?
    
    init(imageEndPoint: String, username: String, caption: String? = nil, comments: [Comment] = [], likes: [Like] = [], uid: String? = nil) {
        self.imageEndPoint = imageEndPoint
        self.username = username
        self.caption = caption
        self.comments = comments
        self.likes = likes
        self.uid = uid
    }
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}
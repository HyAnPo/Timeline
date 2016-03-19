//
//  Comment.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Comment: Equatable {
    
    let username: String
    let text: String
    let postID: String
    let uid: String?
    
    init(username: String, text: String, postID: String, uid: String? = nil) {
        self.username = username
        self.text = text
        self.postID = postID
        self.uid = uid
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}
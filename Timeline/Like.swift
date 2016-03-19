//
//  Like.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Like: Equatable {
    
    let username: String
    let postID: String
    let uid: String?
    
    init(username: String, postID: String, uid: String? = nil) {
        self.username = username
        self.postID = postID
        self.uid = uid
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}
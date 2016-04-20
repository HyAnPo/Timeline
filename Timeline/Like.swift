//
//  Like.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let kUser = "username"
    private let kPost = "post"
    
    let username: String
    let postID: String
    let uid: String?
    
    var endpoint: String {
        return "/post/\(postID)/likes/"
    }
    
    var jsonValue: [String : AnyObject] {
        return [kUser: username, kPost: postID]
    }
    
    init(username: String, postID: String, uid: String? = nil) {
        self.username = username
        self.postID = postID
        self.uid = uid
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUser] as? String,
            let postID = json[kPost] as? String else { return nil }
        
        self.username = username
        self.postID = postID
        self.uid = identifier
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}
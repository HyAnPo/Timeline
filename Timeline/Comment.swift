//
//  Comment.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let kPost = "post"
    private let kUsername = "username"
    private let kText = "text"
    
    let username: String
    let text: String
    let postID: String
    let uid: String?
    
    var endpoint: String {
        return "/posts/\(postID)/comments/"
    }
    
    var jsonValue: [String : AnyObject] {
        return [kPost: postID, kUsername: username, kText: text]
    }
    
    init(username: String, text: String, postID: String, uid: String? = nil) {
        self.username = username
        self.text = text
        self.postID = postID
        self.uid = uid
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
            let text = json[kText] as? String,
            let postID = json[kPost] as? String else { return nil }
        
        self.username = username
        self.text = text
        self.postID = postID
        self.uid = identifier
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}
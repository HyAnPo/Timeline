//
//  Like.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let kPost = "post"
    private let kUsername = "username"
    
    let username: String
    let postIdentifier: String
    let identifier: String?
    var endpoint: String {
        return "/post/\(self.postIdentifier)/likes/"
    }
    
    var jsonValue: [String:AnyObject] {
        return [kUsername: username, kPost: postIdentifier]
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let postIdentifier = json[kPost] as? String,
              let username = json[kUsername] as? String else { return nil }
        
        self.postIdentifier = postIdentifier
        self.username = username
        self.identifier = identifier
    }
    
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func == (lhs: Like, rhs: Like) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}
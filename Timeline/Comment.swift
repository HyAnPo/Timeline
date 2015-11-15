//
//  Comment.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    let username: String
    let text: String
    let postIdentifier: String
    let identifier: String?
    
    init(username: String, text: String, postIdentifier: String, identifier: String? = nil) {
        
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func == (lhs: Comment, rhs: Comment) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}
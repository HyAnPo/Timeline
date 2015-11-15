//
//  User.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    let username: String
    let bio: String?
    let url: String?
    let identifier: String?
    
    init(username: String, bio: String? = nil, url: String? = nil, identifier: String) {
        
        self.username = username
        self.bio = bio
        self.url = url
        self.identifier = identifier
        
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}
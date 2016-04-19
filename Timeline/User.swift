//
//  User.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct User: Equatable {
    
    let username: String
    var bio: String?
    var url: String?
    let uid: String?
    
    init(username: String, uid: String?, bio: String? = nil, url: String? = nil) {
        self.username = username
        self.bio = bio
        self.url = url
        self.uid = uid
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}

extension User: FirebaseType {
    
    
}
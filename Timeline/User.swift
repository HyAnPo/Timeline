//
//  User.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

struct User: Equatable {
    let userName: String
    let bio: String?
    let url: String?
    let identifier: String?
    
    init(userName: String, bio: String? = nil, url: String? = nil, identifier: String) {
        
        self.userName = userName
        self.bio = bio
        self.url = url
        self.identifier = identifier
        
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.userName == rhs.identifier
}
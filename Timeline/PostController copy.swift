//
//  PostController.swift
//  TimeLine
//
//  Created by Taylor Petersen on 11/4/15.
//  Copyright © 2015 Maverick. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
        
    }
    static func addPost(image: UIImage, caption: String?, completion: (post: Post?) -> Void) {
        completion(post: mockPosts().first)
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        completion(post: mockPosts().first)
    }
    
    static func postsForUser(username: String, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
    }
    
    static func deletePost(post: Post, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void?) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        
        return (posts: [])
        
    }
    
    static func mockPosts() -> [Post] {
        
        let sampleImageIdentifier = "-K1l4125TYvKMc7rcp5e"
        
        let like1 = Like(userName: "blaine", postIdentifier: "1234")
        let like2 = Like(userName: "holly", postIdentifier: "4566")
        let like3 = Like(userName: "drake", postIdentifier: "43212")
        
        let comment1 = Comment(userName: "taylor", text: "nice pic", postIdentifier: "1234")
        let comment2 = Comment(userName: "blaine", text: "yeah it was a great shot", postIdentifier: "4566")
        
        let post1 = Post(imageEndPoint: sampleImageIdentifier, caption: "Love the Pic", userName: "kelsi:", comments: [comment1, comment2], likes: [like1, like2, like3])
        let post2 = Post(imageEndPoint: sampleImageIdentifier, caption: "Great Pic", userName: "taylor", comments: [], likes: [])
        let post3 = Post(imageEndPoint: sampleImageIdentifier, caption: "You're a professional", userName: "blaine", comments: [], likes: [])
        
        return [post1, post2, post3]
    }

}
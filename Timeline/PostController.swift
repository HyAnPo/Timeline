//
//  PostController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/19/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]) -> Void) {
        
        completion(posts: mockPosts())
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts().first)
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        completion(post: mockPosts().first)
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        
        completion(posts: mockPosts())
    }
    
    static func deletePost(post: Post) {
        
    }
    
    static func addCommentWithTextToPost(commentText: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts().last)
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return []
    }
    
    static func mockPosts() -> [Post] {
        
        let like1 = Like(username: "Hyrum", postID: "1234")
        let like2 = Like(username: "Andrew", postID: "2345")
        let like3 = Like(username: "Porter", postID: "3456")
        
        let comment1 = Comment(username: "Libby", text: "cute", postID: "1234")
        let comment2 = Comment(username: "Paul", text: "cool", postID: "2345")
        let comment3 = Comment(username: "Mike", text: "awesome", postID: "3456")
        
        let post1 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", username: "haporter", caption: "wow", comments: [comment1], likes: [like1])
        let post2 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", username: "haporter", caption: "noway", comments: [comment2], likes: [like2])
        let post3 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", username: "haporter", caption: "fun", comments: [comment3], likes: [like3])
        
        return [post1, post2, post3]
    }
}
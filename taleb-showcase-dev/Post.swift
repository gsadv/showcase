//
//  Post.swift
//  taleb-showcase-dev
//
//  Created by Hassan Ait-Taleb on 19-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import Foundation

class Post{
    private var _description: String!
    private var _likes: Int!
    private var _imgUrl: String?
    private var _username: String!
    private var _key: String!
    
    var postDescription: String!{
        return _description
    }
   
    var likes: Int{
        return _likes
    }
    
    var imgUrl: String?{
        return _imgUrl
    }
    
    var username: String!{
        return _username
    }
    
    var key: String!{
        return _key
    }
    
    init(descr: String, likes: Int, imgUrl: String ) {
        self._description = descr
        self._likes = likes
        self._imgUrl = imgUrl
    }
    
    init(key: String, post: Dictionary<String,Any>) {
        self._key = key
        
        if let desc = post["description"] as? String {
            self._description = desc
        }
        
        if let like = post["likes"] as? Int {
            self._likes = like
        }
        
        if let imgUrl = post["imgUrl"] as? String {
            self._imgUrl = imgUrl
        }
    }
    
    
    
}

//
//  DataService.swift
//  taleb-showcase-dev
//
//  Created by Hassan Ait-Taleb on 14-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import Foundation
import Firebase

class DataService{
    static let ds = DataService()
    
   private let _REF_BASE = FIRDatabase.database().reference()
   private let _REF_POSTS = FIRDatabase.database().reference(withPath: "posts")
   private let _REF_USERS = FIRDatabase.database().reference(withPath: "users")

    
    var REF_BASE: FIRDatabaseReference{
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>){
        REF_USERS.child(uid).setValue(user) 
        
    }
}

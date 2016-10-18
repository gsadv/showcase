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
        
       // Firebase(url: "https://taleb-showcase.firebaseapp.com")
    var REF_BASE: FIRDatabaseReference{
        return _REF_BASE
    }
}

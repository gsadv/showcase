//
//  ViewController.swift
//  taleb-showcase-dev
//
//  Created by Hassan Ait-Taleb on 13-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbButtonPressed(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"]) { (fasebookResult: FBSDKLoginManagerLoginResult?, facebookError: Error?) in
            
            // werkt alleen als je Key chain sharing aanzet.
            if facebookError != nil {
                print("Facebook loging failed. Error: \(facebookError)")
            } else {
                let accesToken = FBSDKAccessToken.current().tokenString
                print ("Facebook login succesfully. token: \(accesToken)")
            }
        }
    }

    
}


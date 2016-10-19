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
import FirebaseAuth
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var emailField: MaterialTextFiels!
    @IBOutlet weak var passwordField: MaterialTextFiels!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // als je al bent ingelogt dan meteen naar andere scherm via loggedIn
        if  UserDefaults.standard.value(forKey: KEY_UID) != nil {
            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }
        
    }
    
    @IBAction func fbButtonPressed(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()

        facebookLogin.logIn(withReadPermissions: ["email"]) { (fasebookResult: FBSDKLoginManagerLoginResult?, facebookError: Error?) in
            
            // werkt alleen als je Key chain sharing aanzet.
            if facebookError != nil {
                //print("Facebook loging failed. Error: \(facebookError)")
            } else {
                let accesTokenStr = FBSDKAccessToken.current().tokenString
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accesTokenStr!)
                //print ("Facebook login succesfully. token: \(accesTokenStr)")
                
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    
                    if error != nil{
                        print("Login Failed. \(error)")
                    } else {
                      //  print("Logged In: \(user?.providerData)")
                       
                        if let userID = user?.uid , let provider = user?.providerID {
                            
                            let userFireBase = ["provider": (user?.providerID)!,"Bla":"TESTING"] as Dictionary <String,String>
                            DataService.ds.createFirebaseUser(uid: userID, user: userFireBase)
                            
                            // user opslaan in geheugen.
                            UserDefaults.standard.set(userID, forKey: KEY_UID)
                            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)

                        }
                        
                        
                    }
                }
            }
        }
    }

    @IBAction func attemptLogin(_ sender: AnyObject) {
        
        if let email = emailField.text , email != "", let password = passwordField.text , password != ""{

            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
                if error != nil {
                    
                    if error.debugDescription.contains("INVALID_EMAIL"){
                        
                        self.showErrorAllert(title: "Email badly formated", msg: "Enter valid emailadres.")
                    
                    } else if error.debugDescription.contains("USER_NOT_FOUND"){
                        
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { user, err in
                            if err != nil {
                                 print(err)
                                
                            } else {
                                
                                if let userID = user?.uid , let provider = user?.providerID {
                                    
                                    let userFireBase = ["provider": (user?.providerID)!,"Bla":"TESTING EMAIL"] as Dictionary <String,String>
                                    DataService.ds.createFirebaseUser(uid: userID, user: userFireBase)
                                    
                                    // user opslaan in geheugen.
                                    UserDefaults.standard.set(user?.uid, forKey: KEY_UID)
                                    self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                                    
                                }
                                self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                            }
                        })
                    } else if error.debugDescription.contains("ERROR_WRONG_PASSWORD") {
                        self.showErrorAllert(title: "Wrong password", msg: "Enter right password")
                    }
                } else {
                    // user opslaan in geheugen.
                    UserDefaults.standard.set(user?.uid, forKey: KEY_UID)
                    self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)

                }
            })
        
        } else {
            showErrorAllert(title: "email and password required", msg: "You must enter email and password")
        }
    }
    
    func showErrorAllert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


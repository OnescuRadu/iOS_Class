//
//  FirebaseAuthManager.swift
//  FirebaseLogin
//
//  Created by Radu Onescu on 03/04/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    
    var auth = Auth.auth()
    let parentVC: ViewController
    
    init(parentVC: ViewController){
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                parentVC.performSegue(withIdentifier: "showSecret", sender: nil)
            }
        }
    }
    
    func signUp(email:String, password: String) {
        auth.createUser(withEmail: email, password: password) { (result,error) in
            if error == nil {
                print("sucessfuly login")
            }
            else {
                print("failed to login \(error.debugDescription)")
            }
        }
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("sucessfuly login")
            }
            else {
                print("failed to login \(error.debugDescription)")
            }
        }
    }
    
    func signOut(){
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func signInUsingFacebook(token: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        auth.signIn(with: credential) { (result, error) in
            if error == nil {
                print("logged in with facebook to firebase \(result!.description)")
            }
            else {
                print("failed to login to firebase using facebook \(error.debugDescription)")
            }
        }
    }
}

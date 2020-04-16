//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Radu Onescu on 03/04/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var firebaseAuthManager:FirebaseAuthManager?
    var facebookAuthManager:FacebookAuthManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthManager = FirebaseAuthManager(parentVC: self) //enable firebaseManager to update GUI
        facebookAuthManager = FacebookAuthManager(parentVC: self)
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            firebaseAuthManager?.signIn(email: email, password: password)
        }
    }
    
    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        print("signing out")
        firebaseAuthManager?.signOut()
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            if email.count > 5 && password.count > 5{
                firebaseAuthManager!.signUp(email: email, password: password)
            }
        }
    }
    
    @IBAction func facebookLoginBtnPressed(_ sender: UIButton) {
        facebookAuthManager?.loginToFacebook()
    }
    
    @IBAction func loadFacebookDataBtnPressed(_ sender: UIButton) {
        facebookAuthManager?.makeGraphRequest()
    }
}

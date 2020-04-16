//
//  FacebookAuthManager.swift
//  FirebaseLogin
//
//  Created by Radu Onescu on 03/04/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookAuthManager {
    let parentVC: ViewController
    
    init(parentVC: ViewController){
        self.parentVC = parentVC
    }
    
    func makeGraphRequest(){
        if let tokenStr = AccessToken.current?.tokenString{
            let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email, picture"], tokenString: tokenStr, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
            
            let connection = GraphRequestConnection()
            connection.add(graphRequest) { (connection, result, error) in
                if error == nil, let res = result {
                    print("got data from Fb")
                    let dict = res as! [String:Any] // cast to dictionary
                    let name = dict["name"] as! String
                    let email = dict["email"] as! String
                    //let image = dict["picture.width(400)"] as! String
                    print(name, email)
                }
                else {
                    print("error getting data from FB \(error.debugDescription)")
                }
            }
            connection.start()
        }
    }
    
    func loginToFacebook(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: parentVC) { (result) in
            switch result {
            case .cancelled :
                print("login cancelled")
                break
            case .failed(let error):
                print("login failed \(error.localizedDescription)")
                break
            case .success(granted: _, declined: _, token: let token):
                print("login sucess \(token.userID)")
                self.parentVC.firebaseAuthManager?.signInUsingFacebook(token: token.tokenString)
            }
        }
    }
}

//
//  FacebookSignInManager.swift
//  SignInHelper
//
//  Created by Sankalp Gupta on 12/09/20.
//  Copyright © 2020 Sankalp Gupta. All rights reserved.
//

import Foundation
import UIKit
#if canImport(FBSDKLoginKit)
import FBSDKCoreKit
import FBSDKLoginKit


protocol FacebookSignInManagerDelegate {
    func facebookSignIn(didCompleteWithUser facebookUser: FacebookUser)
    func facebookSignIn(didCompleteWithError error: Error)
}


public class FacebookSignInManager: NSObject {
    
    private static var singleInstance : FBSDKLoginManager?
    
    var facebookUser: FacebookUser?
    
    static var shared: FBSDKLoginManager {
        get{
            if singleInstance == nil {
                singleInstance = FBSDKLoginManager()
            }
            
            return singleInstance!
        }
    }
    
    func signIn(loginbutton: FBLoginButton){
        
    }
    
    func signOut(loginbutton: FBLoginButton){
        loginButtonDidLogOut(loginButton)
    }
}

extension FacebookSignInManager: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        GraphRequest(graphPath: "me", parameters: ["fields": " id, name , email"]).start { (connection, result, error) in
            if let error = error {
                self.delegate?.facebookSignIn(didCompleteWithError: error)
            } else {
                if let fields = result as? [String:Any]{
                    let name = fields["name"] as? String
                    let userId = fields["id"] as? String
                    let email = fields["email"] as? String
                    let facebookProfileString = "http:" + "//graph.facebook.com/\(id)/picture?type=large"
                    let authorizationCode = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    facebookUser = FacebookUser(userId: userId, name: name, email: email, authorizationCode: authorizationCode)
                    self.delegate?.facebookSignIn(didCompleteWithUser: facebookUser)
                    
                }
            }
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}

#endif

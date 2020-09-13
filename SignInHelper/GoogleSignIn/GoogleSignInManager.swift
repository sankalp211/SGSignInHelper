//
//  GoogleSignInManager.swift
//  SignInHelper
//
//  Created by Sankalp Gupta on 12/09/20.
//  Copyright © 2020 Sankalp Gupta. All rights reserved.
//

import Foundation
import UIKit
#if canImport(GoogleSignIn)
import GoogleSignIn

protocol GoogleSignInManagerDelegate {
    func googleSignIn(didCompleteWithUser googleUser: GoogleUser)
    func googleSignIn(didCompleteWithError error: Error)
}

public class GoogleSignInManager : NSObject {
    
    private static var singleInstance : GoogleSignInManager?
    
    var googleUser : GoogleUser?
    
    static var sharedInstance: GoogleSignInManager {
        get{
            if singleInstance == nil {
                singleInstance = GoogleSignInManager()
            }
            
            return singleInstance!
        }
    }
    
    var uiDelegate: GoogleSignInManagerDelegate?
    
    var presentingController : UIViewController? {
        didSet {
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance()?.presentingViewController = presentingController
        }
    }
    
    func signIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signOut() {
        if googleUser != nil {
            googleUser = nil
            GIDSignIn.sharedInstance()?.signOut()
        }
    }
}

extension GoogleSignInManager : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.delegate?.googleSignIn(didCompleteWithError: error)
        }
        
        let userId : String = user.userID
        let idToken : String = user.authentication.idToken
        let fullName : String = user.profile.name
        let givenName : String = user.profile.givenName
        let familyName : String = user.profile.familyName
        let email : String = user.profile.email
        
        googleUser = GoogleUser(userId: userId, idToken: idToken, fullName: fullName, givenName: givenName, familyName: familyName, email: email)
        self.delegate?.googleSignIn(didCompleteWithUser: GoogleUser)
        
    }
    
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        self.presentingController?.present(viewController!, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        self.presentingController?.dismiss(animated: true) {() -> Void in }
    }
    
    
}
#endif

//
//  GoogleService.swift
//  SignInHelper
//
//  Created by Sankalp Gupta on 12/09/20.
//  Copyright © 2020 Sankalp Gupta. All rights reserved.
//

import Foundation

public class GoogleService {
    
    var dict = [String: AnyObject]()
    static var singleInstance : GoogleService?
    
    static var shared : GoogleService{
        get {
            if singleInstance == nil{
                singleInstance = GoogleService()
            }
            return singleInstance!
        }
    }
    
    private init() {
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            self.dict = dict
        }
    }
    
    var clientID : String{
        get {
            return dict["CLIENT_ID"] as! String
        }
    }
}

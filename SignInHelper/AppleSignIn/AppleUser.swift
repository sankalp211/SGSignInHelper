//
//  AppleUser.swift
//  SignInHelper
//
//  Created by Sankalp Gupta on 23/07/20.
//  Copyright © 2020 Sankalp Gupta. All rights reserved.
//

import AuthenticationServices

public class AppleUser {
	
	var _userId : String = ""
	var _idToken : String?
	var _givenName : String?
	var _familyName : String?
	var _email : String?
	
	open var userId : String {
		return _userId
	}
	
	open var idToken : String? {
		return _idToken
	}
	
	open var givenName : String? {
		return _givenName
	}
	
	open var familyName : String? {
		return _familyName
	}
	
	open var email : String? {
		return _email
	}
	
	init(userId: String, idToken: String?, givenName: String?, familyName: String?, email: String?) {
		self._userId = userId
		self._idToken = idToken
		self._givenName = givenName
		self._familyName = familyName
		self._email  = familyName
		
	}
	
}

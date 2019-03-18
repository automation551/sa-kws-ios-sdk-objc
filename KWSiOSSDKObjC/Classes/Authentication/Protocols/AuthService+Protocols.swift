//
//  AuthService+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol AuthServiceProtocol: ServiceProtocol {
    
    // Login existing User
    func loginUser(username: String,
                   password: String,
                   completionHandler: @escaping(LoggedUserProtocol?, Error?) -> ())
    
    // Create new User
    func createUser(username: String,
                    password: String,
                    timeZone: String?,
                    dateOfBirth: String?,
                    country: String?,
                    parentEmail: String?,
                    completionHandler: @escaping(LoggedUserProtocol?, Error?) -> ())
}

public protocol SingleSignOnServiceProtocol: ServiceProtocol {
    
    func signOn(url: String,
                parent: UIViewController,
                completionHandler: @escaping(LoggedUserProtocol?, Error?) -> ())
}

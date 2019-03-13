//
//  UserService+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol UserServiceProtocol: ServiceProtocol {
    
    func getUser(userId: Int,
                 token: String,
                 completionHandler: @escaping(UserDetailsProtocol?, Error?) -> ())
    
    func updateUser(details: [String: Any],
                    userId: Int,
                    token: String,
                    completionHandler: @escaping(Error?) -> ())
}

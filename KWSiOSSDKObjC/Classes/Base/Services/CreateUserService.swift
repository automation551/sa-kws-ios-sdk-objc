//
//  CreateUserService.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
@objc public protocol CreateUserService: BaseService {
    
    func createUser(username: String,
                    password: String,
                    dateOfBirth: String,
                    country: String,
                    parentEmail: String,
                    callback: @escaping(AuthUserResponse?,Error?) -> () )
    
}

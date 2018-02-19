//
//  LoginService.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

@objc public protocol LoginService: NSObjectProtocol, BaseService {
    
   func loginUser(username: String,
                   password: String,
                   callback: @escaping(AuthResponse?,Error?) -> () )
    
}

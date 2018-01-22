//
//  LoginService.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

public protocol LoginService{
    
    func loginUser(username: String,
                   password: String,
                   callback: @escaping(Login?,Error?) -> () )
    
}

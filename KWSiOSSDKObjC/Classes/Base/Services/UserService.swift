//
//  UserService.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

import SAMobileBase

@objc public protocol UserService: BaseService {
    
    func getUserDetails(userId:Int,
                        token: String,
                        callback: @escaping(UserDetails?,Error?) -> () )
    
    
    func updateUserDetails(userId:Int,
                           token: String,
                           userDetails: UserDetails,
                           callback: @escaping(Bool, Error?) -> () )
    
    
}

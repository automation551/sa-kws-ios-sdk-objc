//
//  LoggedUser.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 27/03/2018.
//

import Foundation
import SAProtobufs

public class LoggedUser : NSObject, LoggedUserModelProtocol{
    
    public var token: String
    public var tokenData: TokenData
    
    //todo this is NOT a String, needs to update Protobofs to AnyHashable
    public var userId: String
    
    public init(token: String,
                         tokenData: TokenData,
                         //todo this is NOT a String, needs to update Protobofs to AnyHashable
                         userId: String) {
        self.token = token
        self.tokenData = tokenData
        self.userId = userId
    }
    
    
    
    
}

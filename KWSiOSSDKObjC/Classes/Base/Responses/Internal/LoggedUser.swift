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
    
    public var id: AnyHashable
    
    public init(token: String,
                tokenData: TokenData,
                id: AnyHashable) {
        
        self.token = token
        self.tokenData = tokenData
        self.id = id
    }
    
    
    
    
}

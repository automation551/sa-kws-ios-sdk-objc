//
//  UserKWSNetworkEnvironment.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 29/01/2018.
//

import Foundation
import SAMobileBase

public class UserKWSNetworkEnvironment: NSObject, KWSNetworkEnvironment{
    
    public var domain: String
    public let clientSecret: String
    public let clientID: String
    
    public required init(domain: String,
                         appID: String,
                         mobileKey: String) {
        
        self.domain = domain
        self.clientSecret = appID
        self.clientID = mobileKey
    }
}

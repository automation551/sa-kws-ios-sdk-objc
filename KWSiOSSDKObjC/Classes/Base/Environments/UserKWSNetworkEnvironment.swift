//
//  UserKWSNetworkEnvironment.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 29/01/2018.
//

import Foundation
import SAMobileBase


@objc public class UserKWSNetworkEnvironment: NSObject, KWSNetworkEnvironment{
    
    public var domain: String
    public let appID: String
    public let mobileKey: String
    
    public required init(
        
        domain: String,
        appID: String,
        mobileKey: String
        
        ) {
        
        self.domain = domain
        self.appID = appID
        self.mobileKey = mobileKey
        
    }
}

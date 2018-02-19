//
//  MetadataKWS.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

@objc(MetadataKWS)
public final class MetadataKWS: NSObject {
    
    public let userId:      NSNumber?
    public let appId:       NSNumber?
    public let clientId:    String?
    public let scope:       String?
    public let iat:         NSNumber?
    public let exp:         NSNumber?
    public let iss:         String?
    
    public required init(userId:    NSNumber?   = nil,
                         appId:     NSNumber?   = nil,
                         clientId:  String?     = "",
                         scope:     String?     = "",
                         iat:       NSNumber?   = nil,
                         exp:       NSNumber?   = nil,
                         iss:       String?     = "") {
        
        self.userId = userId
        self.appId = appId
        self.clientId = clientId
        self.scope = scope
        self.iat = iat
        self.exp = exp
        self.iss = iss
        
        
    }
    
    
    
}

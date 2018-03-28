//
//  TokenData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

@objc(MetadataKWS)
public final class TokenData: NSObject {
    
    public let userId:      NSNumber?
    public let appId:       NSNumber
    public let clientId:    String
    public let scope:       String?
    public let iat:         NSNumber?
    public let exp:         NSNumber?
    public let iss:         String?
    
    public required init(userId:    NSNumber?   = nil,
                         appId:     NSNumber,
                         clientId:  String,
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
    
    
    // MARK: - Equatable
    public static func ==(lhs: TokenData, rhs: TokenData) -> Bool {
        return lhs.userId == rhs.userId
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TokenData else { return false }
        return self.userId == object.userId
    }
    
    public override var hash: Int {
        return userId!.hashValue
    }
    
    
}

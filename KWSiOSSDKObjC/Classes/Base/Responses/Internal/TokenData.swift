//
//  TokenData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 27/03/2018.
//

import Foundation

public final class TokenData : NSObject {
    
    var userId:         Int?
    var appId:          Int
    var clientId:       String?
    var scope:          String?
    var iss:            String?
    var iat:            Int?
    var exp:            Int?
    
    public init (userId:            Int? = 0,
                 appId:             Int,
                 clientId:          String? = nil,
                 scope:             String? = nil,
                 iss:               String? = nil,
                 iat:               Int? = 0,
                 exp:               Int? = 0) {
        
        self.userId = userId
        self.appId = appId
        self.clientId = clientId
        self.scope = scope
        self.iss = iss
        self.iat = iat
        self.exp = exp
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

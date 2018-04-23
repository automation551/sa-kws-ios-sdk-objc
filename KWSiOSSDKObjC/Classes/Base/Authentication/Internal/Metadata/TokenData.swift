//
//  TokenData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

public struct TokenData: Equatable {
    
    public let userId:      Int?
    public let appId:       Int
    public let clientId:    String
    public let scope:       String?
    public let iat:         Int?
    public let exp:         Int?
    public let iss:         String?
    
    public init(userId:    Int? = nil,
                         appId:     Int,
                         clientId:  String,
                         scope:     String? = "",
                         iat:       Int? = nil,
                         exp:       Int? = nil,
                         iss:       String? = "") {
        
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
    
    public func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TokenData else { return false }
        return self == object
    }
    
    public var hash: Int {
        return userId!.hashValue
    }
}

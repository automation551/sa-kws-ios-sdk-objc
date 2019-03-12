//
//  TokenData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

public struct TokenData: Equatable, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case userId
        case appId
        case clientId
        case scope
        case iat
        case exp
        case iss
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decode(Int.self, forKey: .userId)
        appId = try values.decode(Int.self, forKey: .appId)
        clientId = try values.decode(String.self, forKey: .clientId)
        scope = try values.decode(String.self, forKey: .scope)
        iat = try values.decode(Int.self, forKey: .iat)
        exp = try values.decode(Int.self, forKey: .exp)
        iss = try values.decode(String.self, forKey: .iss)
    }
}


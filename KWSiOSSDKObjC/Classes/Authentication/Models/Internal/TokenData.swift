//
//  TokenData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

public struct TokenData: Codable, Equatable {
    
    public let userId: Int?
    public let appId: Int
    public let clientId: String
    public let scope: String?
    public let iat: Int?
    public let exp: Int?
    public let iss: String?
    
    public init(userId: Int? = nil,
                appId: Int,
                clientId: String,
                scope: String? = "",
                iat: Int? = nil,
                exp: Int? = nil,
                iss: String? = "") {
        
        self.userId = userId
        self.appId = appId
        self.clientId = clientId
        self.scope = scope
        self.iat = iat
        self.exp = exp
        self.iss = iss
    }
        
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? nil
        appId = try values.decode(Int.self, forKey: .appId)
        clientId = try values.decode(String.self, forKey: .clientId)
        scope = try values.decodeIfPresent(String.self, forKey: .scope) ?? ""
        iat = try values.decodeIfPresent(Int.self, forKey: .iat) ?? nil
        exp = try values.decodeIfPresent(Int.self, forKey: .exp) ?? nil
        iss = try values.decodeIfPresent(String.self, forKey: .iss) ?? ""
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
}

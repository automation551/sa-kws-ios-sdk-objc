//
//  LoginAuthResponseModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation

public struct LoginAuthResponseModel: Equatable, LoggedUserProtocol, Codable {
    
    public var token: String
    public var id: AnyHashable
    
    public init(token: String,
                id: AnyHashable) {
        
        self.token = token
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case token = "access_token"
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        token = try values.decode(String.self, forKey: .token)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: CodingKeys.self)
        if let id = id as? Int {
            try container.encode (id, forKey: .id)
        }
        try container.encode (token, forKey: .token)
    }
}

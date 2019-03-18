//
//  AuthUserResponseModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation

public struct AuthUserResponseModel: Equatable, LoggedUserProtocol, Codable {
    
    public var id: AnyHashable
    public var token: String

    public init(id: AnyHashable,
                token: String) {
        
        self.id = id
        self.token = token
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        token = try values.decode(String.self, forKey: .token)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: CodingKeys.self)
        if let id = id as? String {
            try container.encode (id, forKey: .id)
        }
        try container.encode (token, forKey: .token)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case token
    }
}

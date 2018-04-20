//
//  LoggedUser.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 27/03/2018.
//

import Foundation
import SAProtobufs

public struct LoggedUserModel : LoggedUserModelProtocol, Equatable, Encodable {
    
    public var token:       String
    public var tokenData:   TokenData
    public var id:          AnyHashable
    
    public init(token:     String,
                         tokenData: TokenData,
                         id:        AnyHashable) {
        
        self.token = token
        self.tokenData = tokenData
        self.id = id
    }
    
    // MARK: - Equatable
    public static func ==(lhs: LoggedUserModel, rhs: LoggedUserModel) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    
    public  func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LoggedUserModel else { return false }
        return self == object
    }
    
    public var hash: Int {
        return id.hashValue
    }
    
    enum CodingKeys: String, CodingKey  {
        case token = "access_token"
        case id = "id"
        case tokenData = "tokenData"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encode (token, forKey: .token)
//        try container.encode (tokenData, forKey: .tokenData)
        if let id = id as? Int {
            try container.encode (id, forKey: .id)
        }
    }
}

import Foundation
import Decodable
import protocol Decodable.Decodable

extension LoggedUserModel: Decodable {
    
    public static func decode(_ json: Any) throws -> LoggedUserModel {
        
        return try LoggedUserModel (
            token:      json => "access_token",
            tokenData:  json => "tokenData",
            id:         json => "id" as! AnyHashable
        )
    }
}

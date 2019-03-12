//
//  LoggedUser.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 27/03/2018.
//

import Foundation
import SAProtobufs

public struct LoggedUserModel : LoggedUserModelProtocol, Equatable, Codable {
    
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
    
    public func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LoggedUserModel else { return false }
        return self == object
    }
    
    public var hash: Int {
        return id.hashValue
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case token
        case tokenData
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(AnyHashable.self, forKey: .id)
        token = try values.decode(String.self, forKey: .token)
        tokenData = try values.decode(TokenData.self, forKey: .tokenData)
    }
}

//
//  AuthUserResponseModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAProtobufs

public final class AuthUserResponseModel: NSObject, LoggedUserModelProtocol, Codable {
    
    public var id:      AnyHashable
    public var token:   String

    public required init(id:    AnyHashable,
                         token: String) {
        
        self.id = id
        self.token = token
    }    
    
    // MARK: - Equatable
    public static func ==(lhs: AuthUserResponseModel, rhs: AuthUserResponseModel) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.token == rhs.token
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AuthUserResponseModel else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case token
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(AnyHashable.self, forKey: .id)
        token = try values.decode(String.self, forKey: .token)
    }
}

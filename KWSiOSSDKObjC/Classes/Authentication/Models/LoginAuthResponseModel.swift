//
//  LoginAuthResponseModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAProtobufs

public final class LoginAuthResponseModel: NSObject, LoggedUserModelProtocol, Codable {
    
    public var token:   String
    public var id:      AnyHashable
    
    public required init(token: String,
                         id:    AnyHashable) {
    
        self.token = token
        self.id = id
    }
    
    // MARK: - Equatable
    public static func ==(lhs: LoginAuthResponseModel, rhs: LoginAuthResponseModel) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.token == rhs.token
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LoginAuthResponseModel else { return false }
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

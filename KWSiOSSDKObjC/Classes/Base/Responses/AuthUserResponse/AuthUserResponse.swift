//
//  CreateUserResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAProtobufs

@objc(KWSCreateUserResponse)
public final class AuthUserResponse: NSObject, LoggedUserModelProtocol {
    
    public var id: AnyHashable
    public var token: String

    public required init(id: AnyHashable,
                         token: String) {
        
        self.id = id
        self.token = token
        
    }    
    
    // MARK: - Equatable
    public static func ==(lhs: AuthUserResponse, rhs: AuthUserResponse) -> Bool {
        let areEqual = lhs.id == rhs.id
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AuthUserResponse else { return false }
        return self.id == object.id
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
}

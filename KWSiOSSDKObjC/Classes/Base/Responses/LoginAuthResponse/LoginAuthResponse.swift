//
//  LoginAuthResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAProtobufs

@objc(KWSLoginResponse)
public final class LoginAuthResponse: NSObject, LoggedUserModelProtocol {
    
    public var token: String
    public var id: AnyHashable
    
    public required init(token: String,
                         id: AnyHashable) {
    
        self.token = token
        self.id = id
    
    }
    
    // MARK: - Equatable
    public static func ==(lhs: LoginAuthResponse, rhs: LoginAuthResponse) -> Bool {
        let areEqual = lhs.id == rhs.id
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LoginAuthResponse else { return false }
        return self.id == object.id
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
    
}

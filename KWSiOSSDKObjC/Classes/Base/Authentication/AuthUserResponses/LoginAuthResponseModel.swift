//
//  LoginAuthResponseModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAProtobufs

public final class LoginAuthResponseModel: NSObject, LoggedUserModelProtocol {
    
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
}

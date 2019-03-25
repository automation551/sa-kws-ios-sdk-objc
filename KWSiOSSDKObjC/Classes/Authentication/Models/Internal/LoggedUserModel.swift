//
//  LoggedUser.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 27/03/2018.
//

import Foundation

public struct LoggedUserModel : LoggedUserProtocol, Equatable {
    
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
}

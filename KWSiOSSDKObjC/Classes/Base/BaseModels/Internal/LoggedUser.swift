//
//  LoggedUser.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 27/03/2018.
//

import Foundation
import SAProtobufs

public class LoggedUser : NSObject, LoggedUserModelProtocol{
    
    public var token:       String
    public var tokenData:   TokenData
    public var id:          AnyHashable
    
    public required init(token:     String,
                         tokenData: TokenData,
                         id:        AnyHashable) {
        
        self.token = token
        self.tokenData = tokenData
        self.id = id
    }
    
    // MARK: - Equatable
    public static func ==(lhs: LoggedUser, rhs: LoggedUser) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LoggedUser else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return id.hashValue
    }
}

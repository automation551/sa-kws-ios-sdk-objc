//
//  ApplicationProfile.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class ApplicationProfile: NSObject, AppProfileModelProtocol {
    
    public var customField1:    Int?
    public var customField2:    Int?
    public var avatarId:        Int?
    public var name:            String?
    
    public required init(customField1:  Int? = nil,
                         customField2:  Int? = nil,
                         avatarId:      Int? = nil,
                         name:          String?
                         ) {
        
        self.customField1 = customField1
        self.customField2 = customField2
        self.avatarId = avatarId
        self.name = name
    }

    // MARK: - Equatable
    public static func ==(lhs: ApplicationProfile, rhs: ApplicationProfile) -> Bool {
        let areEqual = lhs.name == rhs.name
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {        
        guard let object = object as? ApplicationProfile else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return name!.hashValue
    }
}

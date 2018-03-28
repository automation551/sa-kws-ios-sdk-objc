//
//  ApplicationProfile.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

@objc(KWSSwiftApplicationProfile)
public final class ApplicationProfile: NSObject, AppProfileModelProtocol {
    
    public var customField1:    Int?
    public var customField2:    Int?
    public var avatarId:        Int?
    public var name:            String?
    
    public required init(customField1:  NSNumber? = nil ,
                         customField2:  NSNumber? = nil ,
                         avatarId:      NSNumber? = nil ,
                         name:          String?
                         ) {
        
        self.customField1 = customField1?.intValue
        self.customField2 = customField2?.intValue
        self.avatarId = avatarId?.intValue
        self.name = name
        
    }
    
    public enum CodingKeys: String, CodingKey {
        
        //to encode
        case customField1
        case customField2
        case avatarId
    }
    
    // MARK: - Equatable
    public static func ==(lhs: ApplicationProfile, rhs: ApplicationProfile) -> Bool {
        let areEqual = lhs.name == rhs.name
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ApplicationProfile else { return false }
        return self.name == object.name
    }
    
    public override var hash: Int {
        return name!.hashValue
    }
    
    
}

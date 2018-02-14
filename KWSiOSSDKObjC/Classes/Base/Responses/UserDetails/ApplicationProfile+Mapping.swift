//
//  ApplicationProfile+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ApplicationProfile: Decodable {
    
    public static func decode(_ json: Any) throws -> ApplicationProfile {
        
        return try ApplicationProfile (
            username:                 try json =>? "username",
            customField1:             try json =>? "customField1" as? NSNumber,
            customField2:             try json =>? "customField2" as? NSNumber,
            avatarId:                 try json =>? "avatarId" as? NSNumber
            
        )
    }
}


extension ApplicationProfile: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ApplicationProfile.CodingKeys.self)
        
        if let intCustomField1: Int = customField1?.intValue {
            try container.encode(intCustomField1, forKey: .customField1)
        }
        
        if let intCustomField2: Int = customField2?.intValue {
            try container.encode(intCustomField2, forKey: .customField1)
        }

        if let intAvatarId: Int = avatarId?.intValue {
            try container.encode(intAvatarId, forKey: .customField1)
        }
        
    }
}

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
            
            customField1:             try json =>? "customField1" as? NSNumber,
            customField2:             try json =>? "customField2" as? NSNumber,
            avatarId:                 try json =>? "avatarId" as? NSNumber,
            name:                     try json =>? "username"
            
        )
    }
}


extension ApplicationProfile: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: ApplicationProfile.CodingKeys.self)
        
        try container.encode(customField1, forKey: .customField1)
        try container.encode(customField2, forKey: .customField1)
        try container.encode(avatarId, forKey: .customField1)
        
    }
}

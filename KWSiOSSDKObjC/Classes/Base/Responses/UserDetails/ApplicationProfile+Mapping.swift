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
        
        let customField1Int: Int = (customField1?.intValue)!
        if(customField1Int != nil && customField1Int > 0){
            try container.encode(customField1Int, forKey: .customField1)
        }
        
        let customField2Int: Int = (customField2?.intValue)!
        if(customField2Int != nil && customField2Int > 0){
            try container.encode(customField2, forKey: .customField2)
        }
        
        let avatarIdInt: Int = (avatarId?.intValue)!
        if(avatarIdInt != nil && avatarIdInt > 0){
            try container.encode(avatarIdInt, forKey: .avatarId)
        }
    }
}

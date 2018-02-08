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
            customField1:             try json =>? "customField1" as! NSNumber,
            customField2:             try json =>? "customField2" as! NSNumber,
            avatarId:                 try json =>? "avatarId" as! NSNumber
            
        )
    }
}

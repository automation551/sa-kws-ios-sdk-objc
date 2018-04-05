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
            customField1:             try json =>? "customField1",
            customField2:             try json =>? "customField2",
            avatarId:                 try json =>? "avatarId",
            name:                     try json =>? "username"
        )
    }
}

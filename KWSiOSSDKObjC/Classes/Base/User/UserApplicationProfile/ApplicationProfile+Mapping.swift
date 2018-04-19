//
//  ApplicationProfile+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ApplicationProfileModel: Decodable {
    
    public static func decode(_ json: Any) throws -> ApplicationProfileModel {
        
        return try ApplicationProfileModel (            
            customField1:             try json =>? "customField1",
            customField2:             try json =>? "customField2",
            avatarId:                 try json =>? "avatarId",
            name:                     try json =>? "username"
        )
    }
}

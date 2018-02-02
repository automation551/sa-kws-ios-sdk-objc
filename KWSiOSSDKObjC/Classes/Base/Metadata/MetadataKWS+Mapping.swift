//
//  MetadataKWS+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension MetadataKWS: Decodable {
    
    public static func decode(_ json: Any) throws -> MetadataKWS {
        
        return try MetadataKWS (
            appId: try json =>? "appId",
            clientId: try json =>? "clientId",
            scope: try json =>? "scope",
            iat: try json =>? "iat",
            exp: try json =>? "exp",
            iss: try json =>? "iss"
        )
    }
}

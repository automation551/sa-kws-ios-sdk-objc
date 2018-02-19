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
            userId:         try json =>? "userId"   as? NSNumber,
            appId:          try json =>? "appId"    as? NSNumber,
            clientId:       try json =>? "clientId",
            scope:          try json =>? "scope",
            iat:            try json =>? "iat"      as? NSNumber,
            exp:            try json =>? "exp"      as? NSNumber,
            iss:            try json =>? "iss"
        )
    }
}
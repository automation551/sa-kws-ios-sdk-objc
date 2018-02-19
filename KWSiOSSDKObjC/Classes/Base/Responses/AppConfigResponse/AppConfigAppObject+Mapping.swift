//
//  AppConfigAppObjectResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AppConfigAppObjectResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> AppConfigAppObjectResponse {
        
        return try AppConfigAppObjectResponse (
            id:             try json =>? "id",
            name:           try json =>? "name"
        )
    }
}

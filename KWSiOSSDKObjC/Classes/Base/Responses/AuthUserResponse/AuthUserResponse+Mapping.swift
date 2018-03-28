//
//  AuthUserResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AuthUserResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> AuthUserResponse {
        
        return try AuthUserResponse (
            id:                 try json => "id" as! AnyHashable,
            token:              try json => "token"
        )
    }
}

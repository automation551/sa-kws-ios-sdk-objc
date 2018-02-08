//
//  AuthResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AuthResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> AuthResponse {
        
        return try AuthResponse (
            token:           try json =>? "access_token"
        )
    }
}

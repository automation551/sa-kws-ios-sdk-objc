//
//  LoginAuthResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension LoginAuthResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> LoginAuthResponse {
        
        return try LoginAuthResponse (
            token:       json => "access_token"
            id:          try json => "" // INFO: It's alright if not there
        )
    }
}

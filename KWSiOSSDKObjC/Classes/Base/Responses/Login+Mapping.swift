//
//  Login+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension LoginResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> LoginResponse {
        
        return try LoginResponse (
            token:           try json =>? "access_token"
        )
    }
}

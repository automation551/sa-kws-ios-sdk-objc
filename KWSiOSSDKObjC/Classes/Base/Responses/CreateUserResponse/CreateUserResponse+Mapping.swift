//
//  CreateUserResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension CreateUserResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> CreateUserResponse {
        
        return try CreateUserResponse (
            id:           try json =>? "id",
            token:           try json =>? "token"
        )
    }
}

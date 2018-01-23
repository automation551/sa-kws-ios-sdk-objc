//
//  Login+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension Login: Decodable {
    
    public static func decode(_ json: Any) throws -> Login {
        
        return try Login (
            token:           try json =>? "access_token"
        )
    }
}

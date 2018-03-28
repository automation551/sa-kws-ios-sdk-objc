//
//  AppConfig+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AppConfig: Decodable {
    
    public static func decode(_ json: Any) throws -> AppConfig {
        
        return try AppConfig (
            id:             json => "id",
            name:           json => "name"
        )
    }
}

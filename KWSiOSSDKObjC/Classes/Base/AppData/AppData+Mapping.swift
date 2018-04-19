//
//  AppData+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AppData: Decodable {
    
    public static func decode(_ json: Any) throws -> AppData {
        
        return try AppData (
            value:         json => "value",
            name:          json => "name"        
        )
    }
}

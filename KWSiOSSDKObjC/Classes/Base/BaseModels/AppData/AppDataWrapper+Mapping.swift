//
//  AppDataWrapper+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AppDataWrapper: Decodable {
    
    public static func decode(_ json: Any) throws -> AppDataWrapper {
        
        return try AppDataWrapper (
            results:         json => "results",
            count:           json => "count",
            offset:          json => "offset",
            limit:           json => "limit"
        )
    }
}

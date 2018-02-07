//
//  AppConfigResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AppConfigResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> AppConfigResponse {
        
        return try AppConfigResponse (
            app:           try json =>? "app"
        )
    }
}

//
//  AppConfigWrapper+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AppConfigWrapper: Decodable {
    
    public static func decode(_ json: Any) throws -> AppConfigWrapper {
        
        return AppConfigWrapper (
            app:           try json => "app"            
        )
    }
}

//
//  TokenData+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 28/03/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension TokenData: Decodable {
    
    public static func decode(_ json: Any) throws -> TokenData {
        
        return try TokenData(
            
            userId:     json =>? "userId" ?? 0,
            appId:      json => "appId",
            clientId:   json =>? "clientId" ?? nil,
            scope:      json =>? "scope" ?? nil,
            iss:        json =>? "iss" ?? nil,
            iat:        json =>? "iat" ?? 0,
            exp:        json =>? "exp" ?? 
            
        )
    }
}

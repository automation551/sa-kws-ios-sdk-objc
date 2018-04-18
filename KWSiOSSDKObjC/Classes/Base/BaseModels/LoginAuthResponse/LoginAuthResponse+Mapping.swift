//
//  LoginAuthResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension LoginAuthResponseModel: Decodable {
    
    public static func decode(_ json: Any) throws -> LoginAuthResponseModel {
        
        return try LoginAuthResponseModel (            
            token:       json => "access_token",
            id:          0 // INFO: It's alright if not there
        )
    }
}

//
//  RandoUsernameFakeResponse+Mapping.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension RandomUsernameFakeResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> RandomUsernameFakeResponse {
        
        return try RandomUsernameFakeResponse (
            randomUsername:               try json =>? "randomUsername"
        )
    }
}

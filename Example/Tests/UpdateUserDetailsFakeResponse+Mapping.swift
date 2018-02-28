//
//  UpdateUserDetailsFakeResponse+Mapping.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 14/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UpdateUserDetailsFakeResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> UpdateUserDetailsFakeResponse {
        
        return try UpdateUserDetailsFakeResponse (
            userUpdated:               try json =>? "userUpdated",
            emailUpdated:              try json =>? "emailUpdated",
            permissionsRequested:      try json =>? "permissionsRequested"
        )
    }
}


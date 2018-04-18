//
//  UpdateUserDetailsFakeResponse+Mapping.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UpdateUserDetailsFakeResponseModel: Decodable {
    
    public static func decode(_ json: Any) throws -> UpdateUserDetailsFakeResponseModel {
        
        return try UpdateUserDetailsFakeResponseModel (
            userUpdated:               try json =>? "userUpdated",
            emailUpdated:              try json =>? "emailUpdated",
            permissionsRequested:      try json =>? "permissionsRequested"
        )
    }
}

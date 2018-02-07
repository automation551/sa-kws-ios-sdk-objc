//
//  InvalidErrorResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension InvalidError: Decodable {
    
    public static func decode(_ json: Any) throws -> InvalidError {
        
        return try InvalidError (
            dateOfBirth:            try json =>? "dateOfBirth",
            country:                try json =>? "country",
            parentEmail:            try json =>? "parentEmail",
            password:               try json =>? "password",
            username:               try json =>? "username",
            oauthClientId:          try json =>? "oauthClientId"
            
            
        )
    }
}

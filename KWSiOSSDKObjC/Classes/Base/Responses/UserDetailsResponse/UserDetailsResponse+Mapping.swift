//
//  UserDetailsResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UserDetailsResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> UserDetailsResponse {
        
        return try UserDetailsResponse (
            id:                     try json =>? "id" as? NSNumber,
            username:               try json =>? "username",
            firstName:              try json =>? "firstName",
            lastName:               try json =>? "lastName",
            address:                try json =>? "address",
            dateOfBirth:            try json =>? "dateOfBirth",
            gender:                 try json =>? "gender",
            language:               try json =>? "language",
            email:                  try json =>? "email",
            hasSetParentEmail:      try json =>? "hasSetParentEmail" as? NSNumber,
            applicationProfile:     try json =>? "applicationProfile",
            applicationPermissions: try json =>? "applicationPermissions",
            points:                 try json =>? "points",
            createdAt:              try json =>? "createdAt"
            
        )
    }
}

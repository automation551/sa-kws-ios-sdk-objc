//
//  UserDetails+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UserDetailsModel: Decodable {
    
    public static func decode(_ json: Any) throws -> UserDetailsModel {
        
        return try UserDetailsModel (
            firstName:              try json =>? "firstName",
            lastName:               try json =>? "lastName",
            dateOfBirth:            try json => "dateOfBirth",
            gender:                 try json =>? "gender",
            email:                  try json =>? "email",
            hasSetParentEmail:      try json =>? "hasSetParentEmail",
            createdAt:              try json => "createdAt",
            address:                try json =>? "address",
            applicationProfile:     try json =>? "applicationProfile",
            applicationPermissions: try json =>? "applicationPermissions",
            points:                 try json =>? "points",
            id:                     try json =>? "id" as! AnyHashable,
            name:                   try json =>? "username",
            language:               try json =>? "language",
            consentAgeForCountry:   try json =>  "consentAgeForCountry",
            isMinor:                try json =>  "isMinor"
        )
    }
}


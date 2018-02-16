//
//  UserDetails+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UserDetails: Decodable {
    
    public static func decode(_ json: Any) throws -> UserDetails {
        
        return try UserDetails (
            id:                     try json =>? "id" as? NSNumber,
            username:               try json =>? "username",
            firstName:              try json =>? "firstName",
            lastName:               try json =>? "lastName",
            address:                try json =>? "address",
            dateOfBirth:            try json =>? "dateOfBirth",
            gender:                 try json =>? "gender",
            language:               try json =>? "language",
            email:                  try json =>? "email",
            phoneNumber:            try json =>? "phoneNumber",
            hasSetParentEmail:      try json =>? "hasSetParentEmail" as? NSNumber,
            applicationProfile:     try json =>? "applicationProfile",
            applicationPermissions: try json =>? "applicationPermissions",
            points:                 try json =>? "points",
            createdAt:              try json =>? "createdAt",
            parentEmail:            try json =>? "parentEmail"
        )
    }
}

extension UserDetails: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserDetails.CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(gender, forKey: .gender)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(hasSetParentEmail, forKey: .hasSetParentEmail)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(parentEmail, forKey: .parentEmail)
        
        //address
        try container.encode(address, forKey: .address)
        
        //application profile
        try container.encode(applicationProfile, forKey: .applicationProfile)
        
        //application permissions
        try container.encode(applicationPermissions, forKey: .applicationPermissions)
        
        //points
        try container.encode(points, forKey: .points)
        
    }
}


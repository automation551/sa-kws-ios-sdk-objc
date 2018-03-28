//
//  AllowedFields+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 28/03/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension AllowedFields: Decodable {
    
    public static func decode(_ json: Any) throws -> AllowedFields {
        
        return try AllowedFields (
            email:                  try json => "email",
            firstName:              try json => "firstName",
            lastName:               try json => "lastName",
            city:                   try json => "city",
            postalCode:             try json => "postalCode",
            streetAddress:          try json => "streetAddress",
            country:                try json => "country",
            actionPushNotification: try json => "actionPushNotification"
            
        )
    }
}


extension AllowedFields: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AllowedFields.CodingKeys.self)
        
        try container.encode(email, forKey: .email)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(city, forKey: .city)
        try container.encode(postalCode, forKey: .postalCode)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(country, forKey: .country)
        try container.encode(actionPushNotification, forKey: .actionPushNotification)
        
    }
}

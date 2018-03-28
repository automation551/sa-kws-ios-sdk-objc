//
//  ApplicationPermissions+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ApplicationPermissions: Decodable {
    
    public static func decode(_ json: Any) throws -> ApplicationPermissions {
        
        return try ApplicationPermissions (
            
            notifications:           try json =>? "sendPushNotification"  as? NSNumber,
            address:                 try json =>? "accessAddress"         as? NSNumber,
            firstName:               try json =>? "accessFirstName"       as? NSNumber,
            lastName:                try json =>? "accessLastName"        as? NSNumber,
            email:                   try json =>? "accessEmail"           as? NSNumber,
            streetAddress:           try json =>? "accessStreetAddress"   as? NSNumber,
            city:                    try json =>? "accessCity"            as? NSNumber,
            postalCode:              try json =>? "accessPostalCode"      as? NSNumber,
            country:                 try json =>? "accessCountry"         as? NSNumber,
            newsletter:              try json =>? "sendNewsletter"        as? NSNumber,
            competition:             try json =>? "enterCompetitions"     as? NSNumber
            
        )
    }
}


extension ApplicationPermissions: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ApplicationPermissions.CodingKeys.self)
        
        try container.encode(notifications, forKey: .notifications)
        try container.encode(address, forKey: .address)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(email, forKey: .email)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(postalCode, forKey: .postalCode)
        try container.encode(country, forKey: .country)
        try container.encode(newsletter, forKey: .newsletter)
        try container.encode(competition, forKey: .competition)
    }
    
}

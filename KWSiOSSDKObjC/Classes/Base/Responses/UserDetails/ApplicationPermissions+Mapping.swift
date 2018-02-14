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
    
//    public convenience init(from decoder: Decoder) throws {
//
//    }
    
    public static func decode(_ json: Any) throws -> ApplicationPermissions {
        
        return try ApplicationPermissions (
            accessAddress:                 try json =>? "accessAddress"         as? NSNumber,
            accessFirstName:               try json =>? "accessFirstName"       as? NSNumber,
            accessLastName:                try json =>? "accessLastName"        as? NSNumber,
            accessEmail:                   try json =>? "accessEmail"           as? NSNumber,
            accessStreetAddress:           try json =>? "accessStreetAddress"   as? NSNumber,
            accessCity:                    try json =>? "accessCity"            as? NSNumber,
            accessPostalCode:              try json =>? "accessPostalCode"      as? NSNumber,
            accessCountry:                 try json =>? "accessCountry"         as? NSNumber,
            sendPushNotification:          try json =>? "sendPushNotification"  as? NSNumber,
            sendNewsletter:                try json =>? "sendNewsletter"        as? NSNumber,
            enterCompetitions:             try json =>? "enterCompetitions"     as? NSNumber
        )
    }
}


extension ApplicationPermissions: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ApplicationPermissions.CodingKeys.self)
        
        try container.encode(accessAddress, forKey: .accessAddress)
        try container.encode(accessFirstName, forKey: .accessFirstName)
        try container.encode(accessLastName, forKey: .accessLastName)
        try container.encode(accessEmail, forKey: .accessEmail)
        try container.encode(accessStreetAddress, forKey: .accessStreetAddress)
        try container.encode(accessCity, forKey: .accessCity)
        try container.encode(accessPostalCode, forKey: .accessPostalCode)
        try container.encode(sendPushNotification, forKey: .sendPushNotification)
        try container.encode(sendNewsletter, forKey: .sendNewsletter)
        try container.encode(enterCompetitions, forKey: .enterCompetitions)
    }
    
}

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
            notifications:           try json =>? "sendPushNotification",
            address:                 try json =>? "accessAddress",
            firstName:               try json =>? "accessFirstName",
            lastName:                try json =>? "accessLastName",
            email:                   try json =>? "accessEmail",
            streetAddress:           try json =>? "accessStreetAddress",
            city:                    try json =>? "accessCity",
            postalCode:              try json =>? "accessPostalCode",
            country:                 try json =>? "accessCountry",
            newsletter:              try json =>? "sendNewsletter",
            competition:             try json =>? "enterCompetitions"
        )
    }
}

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
            accessAddress:                 try json =>? "accessAddress" as! NSNumber,
            accessFirstName:               try json =>? "accessFirstName" as! NSNumber,
            accessLastName:                try json =>? "accessLastName" as! NSNumber,
            accessEmail:                   try json =>? "accessEmail" as! NSNumber,
            accessStreetAddress:           try json =>? "accessStreetAddress" as! NSNumber,
            accessCity:                    try json =>? "accessCity" as! NSNumber,
            accessPostalCode:              try json =>? "accessPostalCode" as! NSNumber,
            accessCountry:                 try json =>? "accessCountry" as! NSNumber,
            sendPushNotification:          try json =>? "sendPushNotification" as! NSNumber,
            sendNewsletter:                try json =>? "sendNewsletter" as! NSNumber,
            enterCompetitions:             try json =>? "enterCompetitions" as! NSNumber
        )
    }
}

//
//  UserAddress+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UserAddress: Decodable {
    
    public static func decode(_ json: Any) throws -> UserAddress {
        
        return try UserAddress (
            street:                 try json =>? "street",
            city:                   try json =>? "city",
            postCode:               try json =>? "postCode",
            country:                try json =>? "country"
        )
    }
}


extension UserAddress: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserAddress.CodingKeys.self)
        
        if(street != nil && !(street?.isEmpty)!){
            try container.encode(street, forKey: .street)
        }
        if(city != nil && !(city?.isEmpty)!){
            try container.encode(city, forKey: .city)
        }
        if(postCode != nil && !(postCode?.isEmpty)!){
            try container.encode(postCode, forKey: .postCode)
        }
        if(country != nil && !(country?.isEmpty)!){
            try container.encode(country, forKey: .country)
        }
    }
}

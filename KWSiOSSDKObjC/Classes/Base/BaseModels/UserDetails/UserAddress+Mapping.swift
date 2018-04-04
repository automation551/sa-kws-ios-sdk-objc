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
            country:                try json =>? "country",
            countryCode:            try json =>? "countryCode",
            countryName:            try json =>? "countryName"
        )
    }
}


extension UserAddress: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserAddress.CodingKeys.self)
        
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(postCode, forKey: .postCode)
        try container.encode(country, forKey: .country)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(countryName, forKey: .countryName)
        
    }
}

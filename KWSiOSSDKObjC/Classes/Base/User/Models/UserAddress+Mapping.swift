//
//  UserAddress+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension UserAddressModel: Decodable {
    
    public static func decode(_ json: Any) throws -> UserAddressModel {
        
        return UserAddressModel (
            street:                 try json =>? "street",
            city:                   try json =>? "city",
            postCode:               try json =>? "postCode",
            country:                try json =>? "country",
            countryCode:            try json =>? "countryCode",
            countryName:            try json =>? "countryName"
        )
    }
}

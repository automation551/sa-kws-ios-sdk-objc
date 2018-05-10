//
//  InvalidTypeError+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension InvalidTypeError: Decodable {
    
    public static func decode(_ json: Any) throws -> InvalidTypeError {
        
        return InvalidTypeError (
            dateOfBirth:            try json =>? "dateOfBirth",
            country:                try json =>? "country",
            parentEmail:            try json =>? "parentEmail",
            password:               try json =>? "password",
            username:               try json =>? "username",
            oauthClientId:          try json =>? "oauthClientId",
            addressStreet:          try json =>? "address.street",
            addressPostCode:        try json =>? "address.postCode",
            addressCity:            try json =>? "address.city",
            addressCountry:         try json =>? "address.country",
            permissions:            try json =>? "permissions",
            nameKey:                try json =>? "name",
            email:                  try json =>? "email",
            token:                  try json =>? "token"
        )
    }
}

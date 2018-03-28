//
//  AllowedFields.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 28/03/2018.
//

import Foundation

import SAProtobufs

import Decodable
import protocol Decodable.Decodable

@objc(KWSAllowedFields)
public final class AllowedFields: NSObject /*missing the AllowedFieldsModelProtocol*/ {
    
    //TODO AllowedFields needs adding to Protobufs
    
    public var email:                   Bool
    public var firstName:               Bool
    public var lastName:                Bool
    public var city:                    Bool
    public var postalCode:              Bool
    public var streetAddress:           Bool
    public var country:                 Bool
    public var actionPushNotification:  Bool
    
    public required init(email:                     Bool,
                         firstName:                 Bool,
                         lastName:                  Bool,
                         city:                      Bool,
                         postalCode:                Bool,
                         streetAddress:             Bool,
                         country:                   Bool,
                         actionPushNotification:    Bool
        ) {
        
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.city = city
        self.postalCode = postalCode
        self.streetAddress = streetAddress
        self.country = country
        self.actionPushNotification = actionPushNotification
        
    }
    
    public enum CodingKeys: String, CodingKey {
        
        //to encode
        case email
        case firstName
        case lastName
        case city
        case postalCode
        case streetAddress
        case country
        case actionPushNotification
        
    }
    
}



//
//  InvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation

@objc(KWSInvalidErrorResponse)
public final class InvalidError: NSObject, Error {
    
    //types of "invalid" from API error response
    public let dateOfBirth:     SpecificInvalidError?
    public let country:         SpecificInvalidError?
    public let parentEmail:     SpecificInvalidError?
    public let password:        SpecificInvalidError?
    public let username:        SpecificInvalidError?
    public let oauthClientId:   SpecificInvalidError?
    public let addressStreet:   SpecificInvalidError?
    public let addressPostCode:   SpecificInvalidError?
    public let addressCity:   SpecificInvalidError?
    public let addressCountry:   SpecificInvalidError?
    
    
    
    // MARK: - Initialization
    
    public required init(
        
        dateOfBirth:        SpecificInvalidError? = nil,
        country:            SpecificInvalidError? = nil,
        parentEmail:        SpecificInvalidError? = nil,
        password:           SpecificInvalidError? = nil,
        username:           SpecificInvalidError? = nil,
        oauthClientId:      SpecificInvalidError? = nil,
        addressStreet:      SpecificInvalidError? = nil,
        addressPostCode:    SpecificInvalidError? = nil,
        addressCity:        SpecificInvalidError? = nil,
        addressCountry:     SpecificInvalidError? = nil
        
        ) {
        
        self.dateOfBirth = dateOfBirth
        self.country = country
        self.parentEmail = parentEmail
        self.password = password
        self.username = username
        self.oauthClientId = oauthClientId
        self.addressStreet = addressStreet
        self.addressPostCode = addressPostCode
        self.addressCity = addressCity
        self.addressCountry = addressCountry
        
        
    }
    
    
}

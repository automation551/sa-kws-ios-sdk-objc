//
//  InvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation

public final class InvalidTypeError: NSObject, Error, InvalidTypeErrorWrapperProtocol {
    
    //types of "invalid" from API error response
    public var dateOfBirth:     ErrorProtocol?
    public var country:         ErrorProtocol?
    public var parentEmail:     ErrorProtocol?
    public var password:        ErrorProtocol?
    public var username:        ErrorProtocol?
    public var oauthClientId:   ErrorProtocol?
    public var addressStreet:   ErrorProtocol?
    public var addressPostCode: ErrorProtocol?
    public var addressCity:     ErrorProtocol?
    public var addressCountry:  ErrorProtocol?
    public var permissions:     ErrorProtocol?
    public var nameKey:         ErrorProtocol?
    public var email:           ErrorProtocol?
    public var token:           ErrorProtocol?
    
    // MARK: - Initialization    
    public required init(dateOfBirth:        SpecificError? = nil,
                         country:            SpecificError? = nil,
                         parentEmail:        SpecificError? = nil,
                         password:           SpecificError? = nil,
                         username:           SpecificError? = nil,
                         oauthClientId:      SpecificError? = nil,
                         addressStreet:      SpecificError? = nil,
                         addressPostCode:    SpecificError? = nil,
                         addressCity:        SpecificError? = nil,
                         addressCountry:     SpecificError? = nil,
                         permissions:        SpecificError? = nil,
                         nameKey:            SpecificError? = nil,
                         email:              SpecificError? = nil,
                         token:              SpecificError? = nil) {
        
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
        self.permissions = permissions
        self.nameKey = nameKey
        self.email = email
        self.token = token
    }
}

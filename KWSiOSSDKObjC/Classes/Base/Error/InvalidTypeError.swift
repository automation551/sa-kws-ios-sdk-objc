//
//  InvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import SAProtobufs

public final class InvalidTypeError: NSObject, Error, InvalidTypeErrorWrapperModelProtocol {
    
    //types of "invalid" from API error response
    public var dateOfBirth:     ErrorModelProtocol?
    public var country:         ErrorModelProtocol?
    public var parentEmail:     ErrorModelProtocol?
    public var password:        ErrorModelProtocol?
    public var username:        ErrorModelProtocol?
    public var oauthClientId:   ErrorModelProtocol?
    public var addressStreet:   ErrorModelProtocol?
    public var addressPostCode: ErrorModelProtocol?
    public var addressCity:     ErrorModelProtocol?
    public var addressCountry:  ErrorModelProtocol?
    public var permissions:     ErrorModelProtocol?
    public var nameKey:         ErrorModelProtocol?
    
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
                         nameKey:            SpecificError? = nil) {
        
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
    }
}

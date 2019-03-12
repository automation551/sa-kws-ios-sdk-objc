//
//  InvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import SAProtobufs

public final class InvalidTypeError: NSObject, Error, InvalidTypeErrorWrapperModelProtocol, Codable {
    
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
    public var email:           ErrorModelProtocol?
    public var token:           ErrorModelProtocol?
    
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
    
    enum CodingKeys: String, CodingKey {
        case dateOfBirth
        case country
        case parentEmail
        case password
        case username
        case oauthClientId
        case addressStreet
        case addressPostCode
        case addressCity
        case addressCountry
        case permissions
        case nameKey
        case email
        case token
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateOfBirth = try values.decode(SpecificError.self, forKey: .dateOfBirth)
        country = try values.decode(SpecificError.self, forKey: .country)
        parentEmail = try values.decode(SpecificError.self, forKey: .parentEmail)
        password = try values.decode(SpecificError.self, forKey: .password)
        username = try values.decode(SpecificError.self, forKey: .username)
        oauthClientId = try values.decode(SpecificError.self, forKey: .oauthClientId)
        addressStreet = try values.decode(SpecificError.self, forKey: .addressStreet)
        addressPostCode = try values.decode(SpecificError.self, forKey: .addressPostCode)
        addressCity = try values.decode(SpecificError.self, forKey: .addressCity)
        addressCountry = try values.decode(SpecificError.self, forKey: .addressCountry)
        permissions = try values.decode(SpecificError.self, forKey: .permissions)
        nameKey = try values.decode(SpecificError.self, forKey: .nameKey)
        email = try values.decode(SpecificError.self, forKey: .email)
        token = try values.decode(SpecificError.self, forKey: .token)
    }
}

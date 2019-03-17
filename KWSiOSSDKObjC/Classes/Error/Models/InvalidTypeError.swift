//
//  InvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation

public final class InvalidTypeError: Error, InvalidTypeErrorWrapperProtocol, Codable {
    
    //types of "invalid" from API error response
    public var dateOfBirth: ErrorProtocol?
    public var country: ErrorProtocol?
    public var parentEmail: ErrorProtocol?
    public var password: ErrorProtocol?
    public var username: ErrorProtocol?
    public var oauthClientId: ErrorProtocol?
    public var addressStreet: ErrorProtocol?
    public var addressPostCode: ErrorProtocol?
    public var addressCity: ErrorProtocol?
    public var addressCountry: ErrorProtocol?
    public var permissions: ErrorProtocol?
    public var nameKey: ErrorProtocol?
    public var email: ErrorProtocol?
    public var token: ErrorProtocol?
    
    // MARK: - Initialization    
    public required init(dateOfBirth: SpecificError? = nil,
                         country: SpecificError? = nil,
                         parentEmail: SpecificError? = nil,
                         password: SpecificError? = nil,
                         username: SpecificError? = nil,
                         oauthClientId: SpecificError? = nil,
                         addressStreet: SpecificError? = nil,
                         addressPostCode: SpecificError? = nil,
                         addressCity: SpecificError? = nil,
                         addressCountry: SpecificError? = nil,
                         permissions: SpecificError? = nil,
                         nameKey: SpecificError? = nil,
                         email: SpecificError? = nil,
                         token: SpecificError? = nil) {
        
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
    

    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        dateOfBirth = try values.decodeIfPresent(SpecificError.self, forKey: .dateOfBirth)
        country = try values.decodeIfPresent(SpecificError.self, forKey: .country)
        parentEmail = try values.decodeIfPresent(SpecificError.self, forKey: .parentEmail)
        password = try values.decodeIfPresent(SpecificError.self, forKey: .password)
        username = try values.decodeIfPresent(SpecificError.self, forKey: .username)
        oauthClientId = try values.decodeIfPresent(SpecificError.self, forKey: .oauthClientId)
        addressStreet = try values.decodeIfPresent(SpecificError.self, forKey: .addressStreet)
        addressPostCode = try values.decodeIfPresent(SpecificError.self, forKey: .addressPostCode)
        addressCity = try values.decodeIfPresent(SpecificError.self, forKey: .addressCity)
        addressCountry = try values.decodeIfPresent(SpecificError.self, forKey: .addressCountry)
        permissions = try values.decodeIfPresent(SpecificError.self, forKey: .permissions)
        nameKey = try values.decodeIfPresent(SpecificError.self, forKey: .nameKey)
        email = try values.decodeIfPresent(SpecificError.self, forKey: .email)
        token = try values.decodeIfPresent(SpecificError.self, forKey: .token)
    }
    
    enum CodingKeys: String, CodingKey {
        case dateOfBirth
        case country
        case parentEmail
        case password
        case username
        case oauthClientId
        case addressStreet = "address.street"
        case addressPostCode = "address.postCode"
        case addressCity = "address.city"
        case addressCountry = "address.country"
        case permissions
        case nameKey = "name"
        case email
        case token
    }
}

extension InvalidTypeError {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container (keyedBy: CodingKeys.self)
        
        if let dateOfBirth = dateOfBirth as? SpecificError {
            try container.encode (dateOfBirth, forKey: .dateOfBirth)
        }
        
        if let country = country as? SpecificError {
            try container.encode(country, forKey: .country)
        }
        
        if let parentEmail = parentEmail as? SpecificError {
            try container.encode(parentEmail, forKey: .parentEmail)
        }
        
        if let password = password as? SpecificError {
            try container.encode(password, forKey: .password)
        }
        
        if let username = username as? SpecificError {
            try container.encode(username, forKey: .username)
        }
        
        if let oauthClientId = oauthClientId as? SpecificError {
            try container.encode(oauthClientId, forKey: .oauthClientId)
        }
        
        if let addressStreet = addressStreet as? SpecificError {
            try container.encode(addressStreet, forKey: .addressStreet)
        }
        
        if let addressStreet = addressStreet as? SpecificError {
            try container.encode(addressStreet, forKey: .addressStreet)
        }
        
        if let addressPostCode = addressPostCode as? SpecificError {
            try container.encode(addressPostCode, forKey: .addressPostCode)
        }
        
        if let addressCity = addressCity as? SpecificError {
            try container.encode(addressCity, forKey: .addressCity)
        }
        
        if let addressCountry = addressCountry as? SpecificError {
            try container.encode(addressCountry, forKey: .addressCountry)
        }
        
        if let permissions = permissions as? SpecificError {
            try container.encode(permissions, forKey: .permissions)
        }
        
        if let nameKey = nameKey as? SpecificError {
            try container.encode(nameKey, forKey: .nameKey)
        }
        
        if let email = email as? SpecificError {
            try container.encode(email, forKey: .email)
        }
        
        if let token = token as? SpecificError {
            try container.encode(token, forKey: .token)
        }
    }
}

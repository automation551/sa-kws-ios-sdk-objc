//
//  ApplicationPermissions.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

public struct ApplicationPermissionsModel: Equatable, PermissionsModelProtocols, Codable {
    
    public var notifications: Bool?
    public var address: Bool?
    public var firstName: Bool?
    public var lastName: Bool?
    public var email: Bool?
    public var streetAddress: Bool?
    public var city: Bool?
    public var postalCode: Bool?
    public var country: Bool?
    public var newsletter: Bool?
    public var competition: Bool?
    
    public init(notifications: Bool? = false,
                address: Bool? = false,
                firstName: Bool? = false,
                lastName: Bool? = false,
                email: Bool? = false,
                streetAddress: Bool? = false,
                city: Bool? = false,
                postalCode: Bool? = false,
                country: Bool? = false,
                newsletter: Bool? = false,
                competition: Bool? = false) {
        
        self.notifications = notifications
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.streetAddress = streetAddress
        self.city = city
        self.postalCode = postalCode
        self.country = country
        self.newsletter = newsletter
        self.competition = competition
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        notifications = try values.decodeIfPresent(Bool.self, forKey: .notifications) ?? false
        address = try values.decodeIfPresent(Bool.self, forKey: .address) ?? false
        firstName = try values.decodeIfPresent(Bool.self, forKey: .firstName) ?? false
        lastName = try values.decodeIfPresent(Bool.self, forKey: .lastName) ?? false
        email = try values.decodeIfPresent(Bool.self, forKey: .email) ?? false
        streetAddress = try values.decodeIfPresent(Bool.self, forKey: .streetAddress) ?? false
        city = try values.decodeIfPresent(Bool.self, forKey: .city) ?? false
        postalCode = try values.decodeIfPresent(Bool.self, forKey: .postalCode) ?? false
        country = try values.decodeIfPresent(Bool.self, forKey: .country) ?? false
        newsletter = try values.decodeIfPresent(Bool.self, forKey: .newsletter) ?? false
        competition = try values.decodeIfPresent(Bool.self, forKey: .competition) ?? false
    }
        
    enum CodingKeys: String, CodingKey {
        case notifications = "sendPushNotification"
        case address = "accessAddress"
        case firstName = "accessFirstName"
        case lastName = "accessLastName"
        case email = "accessEmail"
        case streetAddress = "accessStreetAddress"
        case city = "accessCity"
        case postalCode = "accessPostalCode"
        case country = "accessCountry"
        case newsletter = "sendNewsletter"
        case competition = "enterCompetitions"
    }
}

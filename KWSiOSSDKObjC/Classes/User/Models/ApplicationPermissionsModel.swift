//
//  ApplicationPermissions.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class ApplicationPermissionsModel: NSObject, PermissionsModelProtocols, Codable {
    
    public var notifications:       Bool?
    public var address:             Bool?
    public var firstName:           Bool?
    public var lastName:            Bool?
    public var email:               Bool?
    public var streetAddress:       Bool?
    public var city:                Bool?
    public var postalCode:          Bool?
    public var country:             Bool?
    public var newsletter:          Bool?
    public var competition:         Bool?
    
    public required init(notifications:     Bool? = nil,
                         address:           Bool? = nil,
                         firstName:         Bool? = nil,
                         lastName:          Bool? = nil,
                         email:             Bool? = nil,
                         streetAddress:     Bool? = nil,
                         city:              Bool? = nil,
                         postalCode:        Bool? = nil,
                         country:           Bool? = nil,
                         newsletter:        Bool? = nil,
                         competition:       Bool? = nil) {
        
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

    // MARK: - Equatable
    public static func ==(lhs: ApplicationPermissionsModel, rhs: ApplicationPermissionsModel) -> Bool {
        let areEqual = lhs.firstName == rhs.firstName
        && lhs.lastName == rhs.lastName
        && lhs.address == rhs.address
        && lhs.email == rhs.email
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {        
        guard let object = object as? ApplicationPermissionsModel else { return false }
        return self == object
    }
    
    enum CodingKeys: String, CodingKey {
        case notifications
        case address
        case firstName
        case lastName
        case email
        case streetAddress
        case city
        case postalCode
        case country
        case newsletter
        case competition
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notifications = try values.decode(Bool.self, forKey: .notifications)
        address = try values.decode(Bool.self, forKey: .address)
        firstName = try values.decode(Bool.self, forKey: .firstName)
        lastName = try values.decode(Bool.self, forKey: .lastName)
        email = try values.decode(Bool.self, forKey: .email)
        streetAddress = try values.decode(Bool.self, forKey: .streetAddress)
        city = try values.decode(Bool.self, forKey: .city)
        postalCode = try values.decode(Bool.self, forKey: .postalCode)
        country = try values.decode(Bool.self, forKey: .country)
        newsletter = try values.decode(Bool.self, forKey: .newsletter)
        competition = try values.decode(Bool.self, forKey: .competition)
    }
}

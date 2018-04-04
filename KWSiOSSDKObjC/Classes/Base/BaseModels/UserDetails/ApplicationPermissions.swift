//
//  ApplicationPermissions.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class ApplicationPermissions: NSObject, PermissionsModelProtocols {
    
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
    public static func ==(lhs: ApplicationPermissions, rhs: ApplicationPermissions) -> Bool {
        let areEqual = lhs.email == rhs.email
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {        
        guard let object = object as? ApplicationPermissions else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return email!.hashValue
    }
}

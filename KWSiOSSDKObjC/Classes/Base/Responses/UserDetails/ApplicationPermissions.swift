//
//  ApplicationPermissions.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

@objc(KWSSwiftApplicationPermissions)
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
    

    
    public required init(notifications:     NSNumber? = nil,
                         address:           NSNumber? = nil,
                         firstName:         NSNumber? = nil,
                         lastName:          NSNumber? = nil,
                         email:             NSNumber? = nil,
                         streetAddress:     NSNumber? = nil,
                         city:              NSNumber? = nil,
                         postalCode:        NSNumber? = nil,
                         country:           NSNumber? = nil,
                         newsletter:        NSNumber? = nil,
                         competition:       NSNumber? = nil) {
        
        self.notifications = notifications?.boolValue
        self.address = address?.boolValue
        self.firstName = firstName?.boolValue
        self.lastName = lastName?.boolValue
        self.email = email?.boolValue
        self.streetAddress = streetAddress?.boolValue
        self.city = city?.boolValue
        self.postalCode = postalCode?.boolValue
        self.country = country?.boolValue
        self.newsletter = newsletter?.boolValue
        self.competition = competition?.boolValue
        
    }
    
    public enum CodingKeys: String, CodingKey {
        
        //to encode
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
    
    
    // MARK: - Equatable
    public static func ==(lhs: ApplicationPermissions, rhs: ApplicationPermissions) -> Bool {
        let areEqual = lhs.email == rhs.email
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ApplicationPermissions else { return false }
        return self.email == object.email
    }
    
    public override var hash: Int {
        return email!.hashValue
    }
    
    
}

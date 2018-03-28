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
    
    public var notifications:       NSNumber?
    public var address:             NSNumber?
    public var firstName:           NSNumber?
    public var lastName:            NSNumber?
    public var email:               NSNumber?
    public var streetAddress:       NSNumber?
    public var city:                NSNumber?
    public var postalCode:          NSNumber?
    public var country:             NSNumber?
    public var newsletter:          NSNumber?
    public var competition:         NSNumber?
    

    
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
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ApplicationPermissions else { return false }
        return self.firstName == object.firstName
    }
    
    
    
}

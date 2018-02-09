//
//  ApplicationPermissions.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import UIKit

@objc(KWSSwiftApplicationPermissions)
public final class ApplicationPermissions: NSObject {
    
    public let accessAddress:           NSNumber?
    public let accessFirstName:         NSNumber?
    public let accessLastName:          NSNumber?
    public let accessEmail:             NSNumber?
    public let accessStreetAddress:     NSNumber?
    public let accessCity:              NSNumber?
    public let accessPostalCode:        NSNumber?
    public let accessCountry:           NSNumber?
    public let sendPushNotification:    NSNumber?
    public let sendNewsletter:          NSNumber?
    public let enterCompetitions:       NSNumber?
    
    
    
    
    public required init(accessAddress:             NSNumber? = nil,
                         accessFirstName:           NSNumber? = nil,
                         accessLastName:            NSNumber? = nil,
                         accessEmail:               NSNumber? = nil,
                         accessStreetAddress:       NSNumber? = nil,
                         accessCity :               NSNumber? = nil,
                         accessPostalCode:          NSNumber? = nil,
                         accessCountry:             NSNumber? = nil,
                         sendPushNotification:      NSNumber? = nil,
                         sendNewsletter:            NSNumber? = nil,
                         enterCompetitions:         NSNumber? = nil) {
        
        self.accessAddress = accessAddress
        self.accessFirstName = accessFirstName
        self.accessLastName = accessLastName
        self.accessEmail = accessEmail
        self.accessStreetAddress = accessStreetAddress
        self.accessCity = accessCity
        self.accessPostalCode = accessPostalCode
        self.accessCountry = accessCountry
        self.sendPushNotification = sendPushNotification
        self.sendNewsletter = sendNewsletter
        self.enterCompetitions = enterCompetitions
        
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ApplicationPermissions else { return false }
        return self.accessAddress == object.accessAddress
    }
    
    
    
}

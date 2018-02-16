//
//  UserDetailsUserDetails.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import UIKit

import Decodable
import protocol Decodable.Decodable

@objc(KWSUserDetails)
public final class UserDetails: NSObject {
    
    public let id:                          NSNumber?
    public let username:                    String?
    public let firstName:                   String?
    public let lastName:                    String?
    public let address:                     UserAddress?
    public let dateOfBirth:                 String?
    public let gender:                      String?
    public let language:                    String?
    public let email:                       String?
    public let phoneNumber:                 String?
    public let hasSetParentEmail:           NSNumber?
    public let applicationProfile:          ApplicationProfile?
    public let applicationPermissions:      ApplicationPermissions?
    public let points:                      Points?
    public let createdAt:                   String?
    public let parentEmail:                 String?
    
    
    public required init(id:                        NSNumber? = nil,
                         username:                  String? = nil,
                         firstName:                 String? = nil,
                         lastName:                  String? = nil,
                         address:                   UserAddress? = nil,
                         dateOfBirth:               String? = nil,
                         gender:                    String? = nil,
                         language:                  String? = nil,
                         email:                     String? = nil,
                         phoneNumber:               String? = nil,
                         hasSetParentEmail:         NSNumber? = nil,
                         applicationProfile:        ApplicationProfile? = nil,
                         applicationPermissions:    ApplicationPermissions? = nil,
                         points:                    Points? = nil,
                         createdAt:                 String? = nil,
                         parentEmail:               String? = nil) {
        
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.language = language
        self.email = email
        self.phoneNumber = phoneNumber
        self.hasSetParentEmail = hasSetParentEmail
        self.applicationProfile = applicationProfile
        self.applicationPermissions = applicationPermissions
        self.points = points
        self.createdAt = createdAt
        self.parentEmail = parentEmail
    }
    
    public enum CodingKeys: String, CodingKey {
        
        //to encode
        case id
        case username
        case firstName
        case lastName
        case address
        case dateOfBirth
        case gender
        case language
        case email
        case phoneNumber
        case hasSetParentEmail
        case applicationProfile
        case applicationPermissions
        case points
        case createdAt
        case parentEmail
    }
    
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserDetails else { return false }
        return self.id == object.id
    }
    
}

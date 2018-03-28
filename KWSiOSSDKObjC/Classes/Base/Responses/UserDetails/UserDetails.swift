//
//  UserDetailsUserDetails.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

import Decodable
import protocol Decodable.Decodable

@objc(KWSUserDetails)
public final class UserDetails: NSObject, UserDetailsModelProtocol {
    
    public var firstName: String?
    public var lastName: String?
    public var dateOfBirth: String
    public var gender: String?
    public var email: String?
    public var hasSetParentEmail: Bool?
    public var createdAt: String
    public var address: AddressModelProtocol?
    public var applicationProfile: AppProfileModelProtocol?
    public var applicationPermissions: PermissionsModelProtocols?
    public var points: PointsModelProtocols?
    
    public var id: AnyHashable
    public var name: String?
    public var language: String?
    
    //todo add this to Protobufs
    public var allowedFields: AllowedFields?
    
    public required init(firstName:                 String? = nil,
                         lastName:                  String? = nil,
                         dateOfBirth:               String,
                         gender:                    String? = nil,
                         email:                     String? = nil,
                         hasSetParentEmail:         NSNumber? = nil,
                         createdAt:                 String,
                         address:                   UserAddress? = nil,
                         applicationProfile:        ApplicationProfile? = nil,
                         applicationPermissions:    ApplicationPermissions? = nil,
                         points:                    Points? = nil,
                         id:                        AnyHashable,
                         name:                      String? = nil,
                         language:                  String? = nil,
                         allowedFields:              AllowedFields? = nil) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.email = email
        self.hasSetParentEmail = hasSetParentEmail?.boolValue
        self.createdAt = createdAt
        self.address = address
        self.applicationProfile = applicationProfile
        self.applicationPermissions = applicationPermissions
        self.points = points
        self.id = id
        self.name = name
        self.language = language
        self.allowedFields = allowedFields
        
        
    }
    
    
    // MARK: - Equatable
    public static func ==(lhs: UserDetails, rhs: UserDetails) -> Bool {
        let areEqual = lhs.id == rhs.id
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserDetails else { return false }
        return self.id == object.id
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
    
}

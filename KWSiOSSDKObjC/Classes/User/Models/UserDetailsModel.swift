//
//  UserDetailsModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

import Decodable
import protocol Decodable.Decodable

public final class UserDetailsModel: NSObject, UserDetailsProtocol {
    
    public var firstName:                   String?
    public var lastName:                    String?
    public var dateOfBirth:                 String
    public var gender:                      String?
    public var email:                       String?
    public var hasSetParentEmail:           Bool?
    public var createdAt:                   String
    public var address:                     AddressProtocol?
    public var applicationProfile:          AppProfileModelProtocol?
    public var applicationPermissions:      PermissionsModelProtocols?
    public var points:                      PointsProtocols?
    public var id:                          AnyHashable
    public var name:                        String?
    public var language:                    String?
    public var consentAgeForCountry:        Int
    public var isMinor:                     Bool
    
    public required init(firstName:                 String? = nil,
                         lastName:                  String? = nil,
                         dateOfBirth:               String,
                         gender:                    String? = nil,
                         email:                     String? = nil,
                         hasSetParentEmail:         Bool? = nil,
                         createdAt:                 String,
                         address:                   UserAddressModel? = nil,
                         applicationProfile:        ApplicationProfileModel? = nil,
                         applicationPermissions:    ApplicationPermissionsModel? = nil,
                         points:                    PointsModel? = nil,
                         id:                        AnyHashable,
                         name:                      String? = nil,
                         language:                  String? = nil,
                         consentAgeForCountry:      Int,
                         isMinor:                   Bool) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.email = email
        self.hasSetParentEmail = hasSetParentEmail
        self.createdAt = createdAt
        self.address = address
        self.applicationProfile = applicationProfile
        self.applicationPermissions = applicationPermissions
        self.points = points
        self.id = id
        self.name = name
        self.language = language
        self.consentAgeForCountry = consentAgeForCountry
        self.isMinor = isMinor
    }
    
    // MARK: - Equatable
    public static func ==(lhs: UserDetailsModel, rhs: UserDetailsModel) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserDetailsModel else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
    
}

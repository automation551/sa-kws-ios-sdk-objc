//
//  UserDetailsModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class UserDetailsModel: NSObject, UserDetailsModelProtocol, Codable {
    
    public var firstName:                   String?
    public var lastName:                    String?
    public var dateOfBirth:                 String
    public var gender:                      String?
    public var email:                       String?
    public var hasSetParentEmail:           Bool?
    public var createdAt:                   String
    public var address:                     AddressModelProtocol?
    public var applicationProfile:          AppProfileModelProtocol?
    public var applicationPermissions:      PermissionsModelProtocols?
    public var points:                      PointsModelProtocols?
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
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case dateOfBirth
        case gender
        case email
        case hasSetParentEmail
        case createdAt
        case address
        case applicationProfile
        case applicationPermissions
        case points
        case id
        case name
        case language
        case consentAgeForCountry
        case isMinor
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        dateOfBirth = try values.decode(String.self, forKey: .dateOfBirth)
        gender = try values.decode(String.self, forKey: .gender)
        email = try values.decode(String.self, forKey: .email)
        hasSetParentEmail = try values.decode(Bool.self, forKey: .hasSetParentEmail)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        address = try values.decode(UserAddressModel.self, forKey: .address)
        applicationProfile = try values.decode(ApplicationProfileModel.self, forKey: .applicationProfile)
        applicationPermissions = try values.decode(ApplicationPermissionsModel.self, forKey: .applicationPermissions)
        points = try values.decode(PointsModel.self, forKey: .points)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        language = try values.decode(String.self, forKey: .language)
        consentAgeForCountry = try values.decode(Int.self, forKey: .consentAgeForCountry)
        isMinor = try values.decode(Bool.self, forKey: .isMinor)
    }
}

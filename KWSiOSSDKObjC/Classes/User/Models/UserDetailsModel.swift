//
//  UserDetailsModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

public struct UserDetailsModel: Equatable, UserDetailsProtocol, Codable {
    
    public var firstName: String?
    public var lastName: String?
    public var dateOfBirth: String
    public var gender: String?
    public var email: String?
    public var hasSetParentEmail: Bool?
    public var createdAt: String
    public var address: AddressProtocol?
    public var applicationProfile: AppProfileModelProtocol?
    public var applicationPermissions: PermissionsModelProtocols?
    public var points: PointsProtocols?
    public var id: AnyHashable
    public var name: String?
    public var language: String?
    public var consentAgeForCountry: Int
    public var isMinor: Bool
    
    public init(firstName: String? = nil,
                lastName: String? = nil,
                dateOfBirth: String,
                gender: String? = nil,
                email: String? = nil,
                hasSetParentEmail: Bool? = false,
                createdAt: String,
                address: UserAddressModel? = nil,
                applicationProfile: ApplicationProfileModel? = nil,
                applicationPermissions: ApplicationPermissionsModel? = nil,
                points: PointsModel? = nil,
                id: AnyHashable,
                name: String? = nil,
                language: String? = nil,
                consentAgeForCountry: Int,
                isMinor: Bool) {
        
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
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName) ?? nil
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName) ?? nil
        dateOfBirth = try values.decode(String.self, forKey: .dateOfBirth)
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? nil
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? nil
        hasSetParentEmail = try values.decodeIfPresent(Bool.self, forKey: .hasSetParentEmail) ?? false
        createdAt = try values.decode(String.self, forKey: .createdAt)
        address = try values.decode(UserAddressModel.self, forKey: .address)
        applicationProfile = try values.decode(ApplicationProfileModel.self, forKey: .applicationProfile)
        applicationPermissions = try values.decode(ApplicationPermissionsModel.self, forKey: .applicationPermissions)
        points = try values.decode(PointsModel.self, forKey: .points)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? nil
        language = try values.decodeIfPresent(String.self, forKey: .language) ?? nil
        consentAgeForCountry = try values.decode(Int.self, forKey: .consentAgeForCountry)
        isMinor = try values.decode(Bool.self, forKey: .isMinor)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container (keyedBy: CodingKeys.self)
        
        if let id = id as? String {
            try container.encode(id, forKey: .id)
        }
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(gender, forKey: .gender)
        try container.encode(email, forKey: .email)
        try container.encode(hasSetParentEmail, forKey: .hasSetParentEmail)
        try container.encode(createdAt, forKey: .createdAt)
        
        if let address = address as? UserAddressModel {
            try container.encode(address, forKey: .address)
        }
        
        if let applicationProfile = applicationProfile as? ApplicationProfileModel {
            try container.encode(applicationProfile, forKey: .applicationProfile)
        }
        
        if let points = points as? PointsModel {
            try container.encode(points, forKey: .points)
        }
        
        try container.encode(name, forKey: .name)
        try container.encode(language, forKey: .language)
        try container.encode(consentAgeForCountry, forKey: .consentAgeForCountry)
        try container.encode(isMinor, forKey: .isMinor)
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
        case name = "username"
        case language
        case consentAgeForCountry
        case isMinor
    }
}

extension UserDetailsModel {
    
    public static func == (lhs: UserDetailsModel, rhs: UserDetailsModel) -> Bool {
        return lhs.id == rhs.id
    }
}

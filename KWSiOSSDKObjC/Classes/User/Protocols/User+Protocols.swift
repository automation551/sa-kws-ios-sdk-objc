//
//  User+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol AddressProtocol: ModelProtocol {
    
    var street: String? { get }
    var city: String? { get }
    var postCode: String? { get }
    var country: String? { get }
    var countryCode: String? { get }
    var countryName: String? { get }
}

public protocol UserDetailsProtocol: ModelProtocol, UniqueIdentityTraitProtocol, UniqueNameTraitProtocol, MultiLanguageTraitProtocol {
    
    var firstName: String? { get }
    var lastName: String? { get }
    var dateOfBirth: String { get }
    var gender: String? { get }
    var email: String? { get }
    var hasSetParentEmail: Bool? { get }
    var createdAt: String { get }
    var address: AddressProtocol? { get }
    var applicationProfile: AppProfileModelProtocol? { get }
    var applicationPermissions: PermissionsModelProtocols? { get }
    var points: PointsProtocols? { get }
    var consentAgeForCountry: Int { get }
    var isMinor: Bool { get }
}

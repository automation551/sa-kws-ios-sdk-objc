//
//  Permissions+Protocol.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol PermissionsModelProtocols: ModelProtocol {
    
    var notifications: Bool? { get }
    var address: Bool? { get }
    var firstName: Bool? { get }
    var lastName: Bool? { get }
    var email: Bool? { get }
    var streetAddress: Bool? { get }
    var city: Bool? { get }
    var postalCode: Bool? { get }
    var country: Bool? { get }
    var newsletter: Bool? { get }
    var competition: Bool? { get }
}

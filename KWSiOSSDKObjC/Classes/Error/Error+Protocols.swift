//
//  Error+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol ErrorWrapperProtocol: BaseErrorModelProtocol {
    
    var code: Int? { get }
    var codeMeaning: String? { get }
    var invalid: InvalidTypeErrorWrapperProtocol? { get }
    var errorCode: String? { get }
    var error: String? { get }
}

public protocol ErrorProtocol: BaseErrorModelProtocol {
    
    var code: Int? { get }
    var codeMeaning: String? { get }
}

public protocol InvalidTypeErrorWrapperProtocol: ModelProtocol {
    
    var dateOfBirth: ErrorProtocol? { get }
    var country: ErrorProtocol? { get }
    var parentEmail: ErrorProtocol? { get }
    var password: ErrorProtocol? { get }
    var username: ErrorProtocol? { get }
    var oauthClientId: ErrorProtocol? { get }
    var addressStreet: ErrorProtocol? { get }
    var addressPostCode: ErrorProtocol? { get }
    var addressCity: ErrorProtocol? { get }
    var addressCountry: ErrorProtocol? { get }
    var permissions: ErrorProtocol? { get }
    var nameKey: ErrorProtocol? { get }
    var email: ErrorProtocol? { get }
    var token: ErrorProtocol? { get }
    
}

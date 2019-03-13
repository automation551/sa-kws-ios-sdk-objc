//
//  LoggedUser+Protocol.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol LoggedUserProtocol: ModelProtocol, UniqueIdentityTraitProtocol {
    
    var token: String { get }
    
}

//
//  AppProfile+Protocol.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol AppProfileModelProtocol: ModelProtocol, UniqueNameTraitProtocol {
    
    var customField1: Int? { get }
    var customField2: Int? { get }
    var avatarId: Int? { get }
}

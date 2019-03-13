//
//  AppData+Protocol.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

//KWS
public protocol AppDataModelProtocol: ModelProtocol, UniqueNameTraitProtocol {
    
    var value: Int { get }
}

//KWS
public protocol AppDataWrapperModelProtocol: ModelProtocol, ListTraitProtocol {
    
    var results: [AppDataModelProtocol] { get }
}

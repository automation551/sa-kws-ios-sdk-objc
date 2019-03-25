//
//  AppConfig+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

//KWS
public protocol AppConfigModelProtocol: ModelProtocol {
    
    var id: Int { get }
    var name: String { get }
}

//KWS
public protocol AppConfigWrapperModelProtocol: ConfigModelProtocol {
    
    var app: AppConfigModelProtocol { get }
}

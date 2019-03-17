//
//  Abstract+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol AbstractFactoryProtocol {
    func getService <T> (withType type: T.Type) -> T?
}

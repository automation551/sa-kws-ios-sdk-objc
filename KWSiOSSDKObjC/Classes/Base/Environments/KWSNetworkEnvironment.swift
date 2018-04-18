//
//  KWSNetworkEnvironment.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

public protocol KWSNetworkEnvironment : NetworkEnvironmentProtocol {
    
    var clientSecret: String { get }
    var clientID: String { get }
    
}

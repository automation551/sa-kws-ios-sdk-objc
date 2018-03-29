//
//  KWSNetworkEnvironment.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

@objc(KWSNetworkEnv)
public protocol KWSNetworkEnvironment : NetworkEnvironment {
    
    var appID: String { get }
    var mobileKey: String { get }
    
}

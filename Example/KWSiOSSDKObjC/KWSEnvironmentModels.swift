//
//  KWSEnvironmentModels.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import KWSiOSSDKObjC

public class StanTestEnvironment: KWSNetworkEnvironment {
    
    public var domain: String = "https://stan-test-cluster.api.kws.superawesome.tv/"
    public var mobileKey: String = "stan-test"
    public var appID: String = "DRYNvSStuSvnaDg0d3f9t17QybbpQqX4"
    
    public var singleSignOn: String = "https://stan-test-cluster.accounts.kws.superawesome.tv/"
}

public class DemoTestEnvironment: KWSNetworkEnvironment {
    
    public var domain: String = "https://kwsapi.demo.superawesome.tv/"
    public var mobileKey: String = "kws-sdk-testing"
    public var appID: String = "TKZpmBq3wWjSuYHN27Id0hjzN4cIL13D"
    
    public var singleSignOn: String = "https://club.demo.superawesome.tv/"
}


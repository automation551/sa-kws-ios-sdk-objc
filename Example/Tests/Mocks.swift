//
//  Mocks.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import UIKit
import SAMobileBase


class GoodMockNetworkEnvironment: KWSNetworkEnvironment {
    var domain: String = "https://localhost:8080"
    var appID: String = "appID"
    var mobileKey: String = "mobileKey"
}

class BadMockNetworkEnvironment: KWSNetworkEnvironment {
    var domain: String = "jsaksa\\s\\asasaasa"
}


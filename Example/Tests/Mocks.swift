//
//  Mocks.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import UIKit
import SAMobileBase
import KWSiOSSDKObjC


class GoodMockNetworkEnvironment: KWSNetworkEnvironment {
    var domain: String = "https://localhost:8080/"
    var appID: String = "good_app_id"
    var mobileKey: String = "good_mobile_key"
}

class BadMockNetworkEnvironment: KWSNetworkEnvironment {
    var domain: String = "bad_domain"
    var appID: String = "good_app_id"
    var mobileKey: String = "good_mobile_key"
}

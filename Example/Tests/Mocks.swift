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


class GoodMockNetworkEnvironment: ComplianceNetworkEnvironment {
    var domain: String = "https://localhost:8080/"
    var clientSecret: String = "good_mobile_key"
    var clientID: String = "good_app_id"
}

class BadMockNetworkEnvironment: ComplianceNetworkEnvironment {
    var domain: String = "bad_domain"
    var clientSecret: String = "good_mobile_key"
    var clientID: String = "good_app_id"
}

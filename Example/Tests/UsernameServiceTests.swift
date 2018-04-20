//
//  Username+ServiceTests.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 08/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class UsernameServiceTests: XCTestCase {
    
    // class or data to test
    private var service: UsernameServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvirnoment: self.environment)
        self.service = sdk.getService(withType: UsernameServiceProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    func test_Multiple_Stubs(){
        let JSON1: Any? = try? fixtureWithName(name: "app_config_success_response")
        let JSON2: Any? = try? fixtureWithName(name: "random_username_success_response")
        
        stub(everything, json(JSON2!))
        stub(everything, json(JSON1!))
        //todo
    }
}

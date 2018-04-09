//
//  CreateUser_CreateUser+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class CreateUser_CreateUser_ObjectProviderTests: XCTestCase {
    
    // class or data to test
    private var service: AuthServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.service = KWSSDK.getService(value: AuthServiceProtocol.self, environment: self.environment)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    func test_Multiple_Stubs(){
        let JSON1: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let JSON2: Any? = try? fixtureWithName(name: "create_user_success_response")
        
        stub(everything, json(JSON2!))
        stub(everything, json(JSON1!))        
        //todo
    }
}

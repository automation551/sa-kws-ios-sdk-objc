//
//  AuthUserResponse+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class AuthUserResponseModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_AuthUser_Response_Equality() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = AuthUserResponseModel(id: 123, token: "111.111.111")
        
        expect(foo).to(equal(bar))
    }
    
    func test_AuthUserResponse_Response_NotEquality() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = AuthUserResponseModel(id: 321, token: "222.222.222")
        
        expect(foo).toNot(equal(bar))
    }
}

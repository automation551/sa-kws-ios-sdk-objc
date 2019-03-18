//
//  LoginAuthResponse+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//


import XCTest
import Nimble
import KWSiOSSDKObjC

class LoginAuthResponseModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_LoginAuthResponse_Equality() {
        let foo = LoginAuthResponseModel(token: "111.111.111", id: 123)
        let bar = LoginAuthResponseModel(token: "111.111.111", id: 123)
        
        expect(foo).to(equal(bar))
    }
    
    func test_LoginAuthResponse_NotEquality() {
        let foo = LoginAuthResponseModel(token: "111.111.111", id: 123)
        let bar = LoginAuthResponseModel(token: "222.222.222", id: 321)
        
        expect(foo).toNot(equal(bar))
    }
}


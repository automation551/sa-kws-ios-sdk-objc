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
    
    func test_SameEquality_Between_Objc_And_Swift() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = AuthUserResponseModel(id: 321, token: "222.222.222")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_AuthUserResponse_Hash_Is_Equal() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = AuthUserResponseModel(id: 123, token: "111.111.111")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_AuthUserResponse_Hash_Is_Not_Equal() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = AuthUserResponseModel(id: 321, token: "111.111.111")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_Objc_AuthUserResponse_NotEquality_With_Different_Class_And_Same_Identifier() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

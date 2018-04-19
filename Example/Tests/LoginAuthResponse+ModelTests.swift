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
    
    func test_SameEquality_Between_Objc_And_Swift() {
        let foo = LoginAuthResponseModel(token: "111.111.111", id: 123)
        let bar = LoginAuthResponseModel(token: "222.222.222", id: 321)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_LoginAuthResponse_Hash_Is_Equal() {
        let foo = LoginAuthResponseModel(token: "111.111.111", id: 123)
        let bar = LoginAuthResponseModel(token: "111.111.111", id: 123)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_LoginAuthResponse_Hash_Is_Not_Equal() {
        let foo = LoginAuthResponseModel(token: "111.111.111", id: 123)
        let bar = LoginAuthResponseModel(token: "111.111.111", id: 321)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_ObjcLoginAuthResponse_NotEquality_With_Different_Class_And_Same_Identifier() {
        let foo = AuthUserResponseModel(id: 123, token: "111.111.111")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}


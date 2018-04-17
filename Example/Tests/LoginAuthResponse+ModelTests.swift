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

class LoginAuthResponse_ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginAuthResponseEquality() {
        let foo = LoginAuthResponse(token: "111.111.111", id: 123)
        let bar = LoginAuthResponse(token: "111.111.111", id: 123)
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginAuthResponseTestsNotEquality() {
        let foo = LoginAuthResponse(token: "111.111.111", id: 123)
        let bar = LoginAuthResponse(token: "222.222.222", id: 321)
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = LoginAuthResponse(token: "111.111.111", id: 123)
        let bar = LoginAuthResponse(token: "222.222.222", id: 321)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testLoginAuthResponseTestsHashIsEqual() {
        let foo = LoginAuthResponse(token: "111.111.111", id: 123)
        let bar = LoginAuthResponse(token: "111.111.111", id: 123)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testLoginAuthResponseTestsHashIsNotEqual() {
        let foo = LoginAuthResponse(token: "111.111.111", id: 123)
        let bar = LoginAuthResponse(token: "111.111.111", id: 321)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcLoginAuthResponseTestsNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}


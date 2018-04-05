//
//  AuthUserResponseTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class AuthUserResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAuthUserResponseEquality() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = AuthUserResponse(id: 123, token: "111.111.111")
        
        expect(foo).to(equal(bar))
    }
    
    func testAuthUserResponseTestsNotEquality() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = AuthUserResponse(id: 321, token: "222.222.222")
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = AuthUserResponse(id: 321, token: "222.222.222")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testAuthUserResponseTestsHashIsEqual() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = AuthUserResponse(id: 123, token: "111.111.111")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testAuthUserResponseTestsHashIsNotEqual() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = AuthUserResponse(id: 321, token: "111.111.111")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcAuthUserResponseTestsNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = AuthUserResponse(id: 123, token: "111.111.111")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

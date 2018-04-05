//
//  TokenDataTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class TokenDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTokenDataEquality() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo).to(equal(bar))
    }
    
    func testTokenDataNotEquality() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 222, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 222, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testTokenDataHashIsEqual() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testTokenDataHashIsNotEqual() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 222, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcTokenDataNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

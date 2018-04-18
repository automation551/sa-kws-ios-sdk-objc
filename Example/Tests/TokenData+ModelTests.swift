//
//  TokenData+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class TokenDataModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_TokenData_Equality() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo).to(equal(bar))
    }
    
    func test_TokenData_NotEquality() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 222, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_BetweenObjcAndSwift() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 222, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_TokenData_HashIsEqual() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_TokenData_HashIsNotEqual() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = TokenData(userId: 222, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_ObjcTokenData_NotEquality_WithDifferentClassAndSameIdentifier() {
        let foo = TokenData(userId: 111, appId: 999, clientId: "client_id_1", scope: "scope_1", iat: 10, exp: 10, iss: "iss_1")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

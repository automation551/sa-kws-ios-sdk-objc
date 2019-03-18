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
}

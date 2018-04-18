//
//  LoggedUser+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class LoggedUserModelTests: XCTestCase {
 
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_LoggedUser_Equality() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        
        expect(foo).to(equal(bar))
    }
    
    func test_LoggedUser_NotEquality() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 222)
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_BetweenObjcAndSwift() {
       
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 222)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_LoggedUser_HashIsEqual() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_LoggedUser_HashIsNotEqual() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 222)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_ObjcLoggedUser_NotEquality_WithDifferentClassAndSameIdentifier() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

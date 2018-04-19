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
    
    func test_SameEquality_Between_Objc_And_Swift() {
       
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 222)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_LoggedUser_Hash_Is_Equal() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_LoggedUser_Hash_Is_Not_Equal() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 222)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_Objc_LoggedUser_Not_Equality_With_Different_Class_And_Same_Identifier() {
        
        let tokenData = TokenData(appId: 123, clientId: "client_id")
        
        let foo = LoggedUserModel(token: "111.111.111", tokenData: tokenData, id: 111)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

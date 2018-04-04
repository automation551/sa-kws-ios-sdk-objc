//
//  CreateUserTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC


class CreateUserTests: XCTestCase {
    
    
    let goodToken: String = "good_token"
    let badToken: String = "bad_token"
    
    let goodID: Int = 1
    let badID: Int = -1
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCreateUserEquality() {
        let foo = AuthUserResponse(id: goodID,token: goodToken)
        let bar = AuthUserResponse(id: goodID, token: goodToken)
        
        expect(foo).to(equal(bar))
    }
    
    func testCreateUserNotEquality() {
        let foo = AuthUserResponse(id: goodID, token: goodToken)
        let bar = AuthUserResponse(id: badID, token: badToken)
        
        expect(foo).toNot(equal(bar))
    }
    
    
    // MARK: Objective-C
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = AuthUserResponse(id: goodID, token: goodToken)
        let bar = AuthUserResponse(id: badID, token: badToken)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcCreateUserNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = AuthUserResponse(id: goodID, token: goodToken)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
    
}

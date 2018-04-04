//
//  LoginTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC


class LoginTests: XCTestCase {
  
    let goodToken: String = "good_token"
    let badToken: String = "bad_token"
    
    let id: Int = 123
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLoginEquality() {
        let foo = LoginAuthResponse(token: goodToken, id: id)
        let bar = LoginAuthResponse(token: goodToken, id: id)
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = LoginAuthResponse(token: goodToken, id: id)
        let bar = LoginAuthResponse(token: badToken, id: id)
        
        expect(foo).toNot(equal(bar))
    }
    
    // MARK: Objective-C
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = LoginAuthResponse(token: goodToken, id: id)
        let bar = LoginAuthResponse(token: badToken, id: id)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = LoginAuthResponse(token: goodToken, id: id)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
    
}

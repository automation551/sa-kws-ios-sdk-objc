//
//  LoginRequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 29/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import SAMobileBase
import Nimble
import KWSiOSSDKObjC


class LoginRequestTests: BaseTest {
    

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testLoginEquality() {
        let foo = Login(token: "good_token")
        let bar = Login(token: "good_token")
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = Login(token: "good_token")
        let bar = Login(token: "bad_token")
        
        expect(foo).toNot(equal(bar))
    }
    
    // MARK: Objective-C
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = Login(token: "good_token")
        let bar = Login(token: "bad_token")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = Login(token: "good_token")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
    
    
}

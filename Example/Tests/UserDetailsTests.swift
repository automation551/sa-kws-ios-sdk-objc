//
//  UserDetailsTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UserDetailsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserDetailsEquality() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        
        expect(foo).to(equal(bar))
    }
    
    func testUserDetailsNotEquality() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321)
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testUserDetailsHashIsEqual() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testUserDetailsHashIsNotEqual() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcUserDetailsNotEqualityWithDifferentClassAndSameIdentifier() {
         let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

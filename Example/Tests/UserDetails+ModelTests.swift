//
//  UserDetails+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UserDetails_ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserDetailsEquality() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo).to(equal(bar))
    }
    
    func testUserDetailsNotEquality() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321, consentAgeForCountry: 13, isMinor: true)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testUserDetailsHashIsEqual() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testUserDetailsHashIsNotEqual() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcUserDetailsNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = UserDetails(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

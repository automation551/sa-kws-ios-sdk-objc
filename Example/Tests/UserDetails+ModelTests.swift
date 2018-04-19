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

class UserDetailsModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UserDetails_Equality() {
        let foo = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo).to(equal(bar))
    }
    
    func test_UserDetails_NotEquality() {
        let foo = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_BetweenObjcAndSwift() {
        let foo = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321, consentAgeForCountry: 13, isMinor: true)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_UserDetails_Hash_Is_Equal() {
        let foo = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_UserDetails_Hash_Is_Not_Equal() {
        let foo = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 321, consentAgeForCountry: 13, isMinor: true)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_Objc_UserDetails_Not_Equality_With_Different_Class_And_Same_Identifier() {
        let foo = UserDetailsModel(dateOfBirth: "2012-03-03", createdAt: "2018-01-02", id: 123, consentAgeForCountry: 13, isMinor: true)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

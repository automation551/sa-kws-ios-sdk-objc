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
}

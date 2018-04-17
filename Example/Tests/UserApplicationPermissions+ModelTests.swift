//
//  UserApplicationPermissions+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UserApplicationPermissions_ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApplicationPermissionsEquality() {
        let foo = ApplicationPermissions(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = ApplicationPermissions(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        
        expect(foo).to(equal(bar))
    }
    
    func testApplicationPermissionsNotEquality() {
        let foo = ApplicationPermissions(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = ApplicationPermissions(notifications: true, address: false, firstName: false, lastName: false, email: false, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = ApplicationPermissions(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = ApplicationPermissions(notifications: true, address: false, firstName: false, lastName: false, email: false, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcApplicationPermissionsNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = ApplicationPermissions(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

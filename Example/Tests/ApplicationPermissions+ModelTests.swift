//
//  ApplicationPermissions+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class ApplicationPermissionsModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ApplicationPermissions_Equality() {
        let foo = ApplicationPermissionsModel(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = ApplicationPermissionsModel(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        
        expect(foo).to(equal(bar))
    }
    
    func test_ApplicationPermissions_NotEquality() {
        let foo = ApplicationPermissionsModel(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = ApplicationPermissionsModel(notifications: true, address: false, firstName: false, lastName: false, email: false, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_BetweenObjcAndSwift() {
        let foo = ApplicationPermissionsModel(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = ApplicationPermissionsModel(notifications: true, address: false, firstName: false, lastName: false, email: false, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_ObjcApplicationPermissions_NotEquality_WithDifferentClassAndSameIdentifier() {
        let foo = ApplicationPermissionsModel(notifications: true, address: true, firstName: true, lastName: true, email: true, streetAddress: true, city: true, postalCode: true, country: true, newsletter: true, competition: true)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

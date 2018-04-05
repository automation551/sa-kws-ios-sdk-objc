//
//  UserAddress.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UserAddressTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserAddressEquality() {
        let foo = UserAddress(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        let bar = UserAddress(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        
        expect(foo).to(equal(bar))
    }
    
    func testUserAddressNotEquality() {
        let foo = UserAddress(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        let bar = UserAddress(street: nil, city: "Manchester", postCode: "M11 11L", country: nil, countryCode: "UK", countryName: nil)
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = UserAddress(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        let bar = UserAddress(street: nil, city: "Manchester", postCode: "M11 11L", country: nil, countryCode: "UK", countryName: nil)
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcUserAddressNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = UserAddress(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

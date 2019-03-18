//
//  UserAddress+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UserAddressModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UserAddress_Equality() {
        let foo = UserAddressModel(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        let bar = UserAddressModel(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        
        expect(foo).to(equal(bar))
    }
    
    func test_UserAddress_NotEquality() {
        let foo = UserAddressModel(street: nil, city: "London", postCode: "N12 21L", country: nil, countryCode: "GB", countryName: nil)
        let bar = UserAddressModel(street: nil, city: "Manchester", postCode: "M11 11L", country: nil, countryCode: "UK", countryName: nil)
        expect(foo).toNot(equal(bar))
    }
}

//
//  AppDataTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class AppDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAppDataEquality() {
        let foo =  AppData(value: 123, name: "new_value")
        let bar =  AppData(value: 123, name: "new_value")
        
        expect(foo).to(equal(bar))
    }
    
    func testAppDataTestsNotEquality() {
        let foo =  AppData(value: 123, name: "new_value")
        let bar =  AppData(value: 321, name: "new_value_2")
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo =  AppData(value: 123, name: "new_value")
        let bar =  AppData(value: 321, name: "new_value_2")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcAppDataTestsNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo =  AppData(value: 123, name: "new_value")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

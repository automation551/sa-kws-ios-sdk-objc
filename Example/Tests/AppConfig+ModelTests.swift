//
//  AppConfig+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class AppConfig_ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAppConfigEquality() {
        let foo = AppConfig(id: 123, name: "app_name_abc")
        let bar = AppConfig(id: 123, name: "app_name_abc")
        
        expect(foo).to(equal(bar))
    }
    
    func testAppConfigTestsNotEquality() {
        let foo = AppConfig(id: 123, name: "app_name_abc")
        let bar = AppConfig(id: 321, name: "app_name_abc")
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = AppConfig(id: 123, name: "app_name_abc")
        let bar = AppConfig(id: 321, name: "app_name_abc")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testAppConfigTestsHashIsEqual() {
        let foo = AppConfig(id: 123, name: "app_name_abc")
        let bar = AppConfig(id: 123, name: "app_name_abc")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testAppConfigTestsHashIsNotEqual() {
        let foo = AppConfig(id: 123, name: "app_name_abc")
        let bar = AppConfig(id: 321, name: "app_name_abc")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcAppConfigTestsNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = AppConfig(id: 123, name: "app_name_abc")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

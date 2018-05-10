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

class AppConfigModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_AppConfig_Equality() {
        let foo = AppConfigModel(id: 123, name: "app_name_abc")
        let bar = AppConfigModel(id: 123, name: "app_name_abc")
        
        expect(foo).to(equal(bar))
    }
    
    func test_AppConfig_NotEquality() {
        let foo = AppConfigModel(id: 123, name: "app_name_abc")
        let bar = AppConfigModel(id: 321, name: "app_name_abc")
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_Between_Objc_And_Swift() {
        let foo = AppConfigModel(id: 123, name: "app_name_abc")
        let bar = AppConfigModel(id: 321, name: "app_name_abc")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_AppConfig_Hash_Is_Equal() {
        let foo = AppConfigModel(id: 123, name: "app_name_abc")
        let bar = AppConfigModel(id: 123, name: "app_name_abc")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_AppConfig_Hash_Is_Not_Equal() {
        let foo = AppConfigModel(id: 123, name: "app_name_abc")
        let bar = AppConfigModel(id: 321, name: "app_name_abc")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_Objc_AppConfig_Not_Equality_With_Different_Class_And_Same_Identifier() {
        let foo = AppConfigModel(id: 123, name: "app_name_abc")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}
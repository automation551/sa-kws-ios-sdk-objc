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
        let foo = AppConfigModel(id: 123, name: "app")
        let bar = AppConfigModel(id: 123, name: "app")
        
        expect(foo).to(equal(bar))
    }
    
    func test_AppConfig_NotEquality() {
        let foo = AppConfigModel(id: 123, name: "app_name_afc")
        let bar = AppConfigModel(id: 321, name: "app_name_abc")
        
        expect(foo).toNot(equal(bar))
    }
}

//
//  ApplicationProfile+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class ApplicationProfileModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Application_ProfileEquality() {
        let foo = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        let bar = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        
        expect(foo).to(equal(bar))
    }
    
    func test_ApplicationProfile_NotEquality() {
        let foo = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        let bar = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 321, name: "cooltiger2")
        expect(foo).toNot(equal(bar))
    }
}

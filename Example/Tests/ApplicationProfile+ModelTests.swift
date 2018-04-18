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
    
    func test_SameEquality_BetweenObjcAndSwift() {
        let foo = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        let bar = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 321, name: "cooltiger2")
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_ApplicationProfile_HashIsEqual() {
        let foo = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        let bar = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_ApplicationProfile_HashIsNotEqual() {
        let foo = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        let bar = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger2")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_ObjcApplicationProfile_NotEquality_WithDifferentClassAndSameIdentifier() {
        let foo = ApplicationProfileModel(customField1: nil, customField2: nil, avatarId: 123, name: "cooltiger1")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

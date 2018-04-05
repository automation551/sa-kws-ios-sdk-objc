//
//  ApplicationProfileTest.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class ApplicationProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApplicationProfileEquality() {
        let foo = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        let bar = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        
        expect(foo).to(equal(bar))
    }
    
    func testApplicationProfileNotEquality() {
        let foo = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        let bar = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 321, name: "coolpokemon2")
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        let bar = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 321, name: "coolpokemon2")
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testApplicationProfileHashIsEqual() {
        let foo = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        let bar = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func testApplicationProfileHashIsNotEqual() {
        let foo = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        let bar = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon2")
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func testObjcApplicationProfileNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = ApplicationProfile(customField1: nil, customField2: nil, avatarId: 123, name: "coolpokemon1")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

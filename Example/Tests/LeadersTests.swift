//
//  LeadersTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 10/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class LeadersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandomUsernameEquality() {
        let foo = Leaders(score: 20, rank: 1, name: "testusr9112")
        let bar = Leaders(score: 20, rank: 1, name: "testusr9112")
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = Leaders(score: 20, rank: 1, name: "testusr9112")
        let bar = Leaders(score: 10, rank: 2, name: "testusr2119")
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = Leaders(score: 20, rank: 1, name: "testusr9112")
        let bar = Leaders(score: 10, rank: 2, name: "testusr2119")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = Leaders(score: 20, rank: 1, name: "testusr9112")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}


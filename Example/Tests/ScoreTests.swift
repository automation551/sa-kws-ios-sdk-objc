//
//  ScoreTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 10/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class ScoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandomUsernameEquality() {
        let foo = Score(score: 20, rank: 1)
        let bar = Score(score: 20, rank: 1)
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = Score(score: 20, rank: 1)
        let bar = Score(score: 10, rank: 2)
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = Score(score: 20, rank: 1)
        let bar = Score(score: 10, rank: 2)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = Score(score: 20, rank: 1)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

//
//  RandomUsernameTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class RandomUsernameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandomUsernameEquality() {
        let foo = RandomUsername(randomUsername: "good_random_username")
        let bar = RandomUsername(randomUsername: "good_random_username")
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = RandomUsername(randomUsername: "good_random_username")
        let bar = RandomUsername(randomUsername: "bad_random_username")
        
        expect(foo).toNot(equal(bar))
    }
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = RandomUsername(randomUsername: "good_random_username")
        let bar = RandomUsername(randomUsername: "bad_random_username")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = RandomUsername(randomUsername: "good_random_username")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

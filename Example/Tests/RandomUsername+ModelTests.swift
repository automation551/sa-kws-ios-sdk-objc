//
//  RandomUsername+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class RandomUsernameModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_RandomUsername_Equality() {
        let foo = RandomUsernameModel(randomUsername: "good_random_username")
        let bar = RandomUsernameModel(randomUsername: "good_random_username")
        
        expect(foo).to(equal(bar))
    }
    
    func test_RandomUsername_NotEquality() {
        let foo = RandomUsernameModel(randomUsername: "good_random_username")
        let bar = RandomUsernameModel(randomUsername: "bad_random_username")
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_BetweenObjcAndSwift() {
        let foo = RandomUsernameModel(randomUsername: "good_random_username")
        let bar = RandomUsernameModel(randomUsername: "bad_random_username")
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_ObjcRandomUsername_NotEquality_WithDifferentClassAndSameIdentifier() {
        let foo = RandomUsernameModel(randomUsername: "good_random_username")
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

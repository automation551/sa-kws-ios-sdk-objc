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

    let goodRandomUsername: String = "good_random_username"
    let badRandomUsername: String = "bad_random_username"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRandomUsernameEquality() {
        let foo = RandomUsernameResponse(randomUsername: goodRandomUsername)
        let bar = RandomUsernameResponse(randomUsername: goodRandomUsername)
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = RandomUsernameResponse(randomUsername: goodRandomUsername)
        let bar = RandomUsernameResponse(randomUsername: badRandomUsername)
        
        expect(foo).toNot(equal(bar))
    }
    
    // MARK: Objective-C
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = RandomUsernameResponse(randomUsername: goodRandomUsername)
        let bar = RandomUsernameResponse(randomUsername: badRandomUsername)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = RandomUsernameResponse(randomUsername: goodRandomUsername)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }

}

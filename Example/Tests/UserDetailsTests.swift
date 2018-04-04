//
//  UserDetailsTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UserDetailsTests: XCTestCase {


    let goodId: NSNumber = 123
    let badId: NSNumber = 321
    
    let dob : String = "2012-03-03"
    let createdAt : String = "2018-01-02"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLoginEquality() {
        let foo = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: goodId)
        let bar = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: goodId)
        
        expect(foo).to(equal(bar))
    }
    
    func testLoginNotEquality() {
        let foo = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: goodId)
        let bar = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: badId)
        
        expect(foo).toNot(equal(bar))
    }
    
    // MARK: Objective-C
    
    func testSameEqualityBetweenObjcAndSwift() {
        let foo = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: goodId)
        let bar = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: badId)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func testObjcLoginNotEqualityWithDifferentClassAndSameIdentifier() {
        let foo = UserDetails(dateOfBirth: dob, createdAt: createdAt, id: goodId)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }


}

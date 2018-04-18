//
//  Points+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class PointsModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Points_Equality() {
        let foo = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        let bar = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        
        expect(foo).to(equal(bar))
    }
    
    func test_Points_NotEquality() {
        let foo = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        let bar = PointsModel(pending: 110, received: 220, total: 330, balance: 440, inApp: 550)
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_BetweenObjcAndSwift() {
        let foo = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        let bar = PointsModel(pending: 110, received: 220, total: 330, balance: 440, inApp: 550)
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_Points_HashIsEqual() {
        let foo = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        let bar = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
                
        expect(foo.hash).to(equal(bar.hash))
    }
    
    func test_Points_HashIsNotEqual() {
        let foo = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        let bar = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 550)
        
        expect(foo.hash).toNot(equal(bar.hash))
    }
    
    func test_ObjcPoints_NotEquality_WithDifferentClassAndSameIdentifier() {
        let foo = PointsModel(pending: 11, received: 22, total: 33, balance: 44, inApp: 55)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

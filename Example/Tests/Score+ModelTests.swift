//
//  Score+ModelTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 10/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class ScoreModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Score_Equality() {
        let foo = ScoreModel(score: 20, rank: 1)
        let bar = ScoreModel(score: 20, rank: 1)
        
        expect(foo).to(equal(bar))
    }
    
    func test_Score_NotEquality() {
        let foo = ScoreModel(score: 20, rank: 1)
        let bar = ScoreModel(score: 10, rank: 2)
        
        expect(foo).toNot(equal(bar))
    }
    
    func test_SameEquality_Between_Objc_And_Swift() {
        let foo = ScoreModel(score: 20, rank: 1)
        let bar = ScoreModel(score: 10, rank: 2)
        
        let objc = foo.isEqual(bar)
        let swift = foo == bar
        
        expect(objc).to(equal(swift))
    }
    
    func test_ObjcScore_NotEquality_With_Different_Class_And_Same_Identifier() {
        let foo = ScoreModel(score: 20, rank: 1)
        let bar = "12345"
        
        expect(foo.isEqual(bar)).to(beFalse())
    }
}

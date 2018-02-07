//
//  RandomUsername_DoRandomUsernameFetch+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC


class RandomUsername_DoRandomUsernameFetch_MappingTests : XCTest{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    //Random Username fetch mapping
    func test_RandomUsername_DoRandomUsernameFetch_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"random_username_success_response")
        
        let randomUsernameResponse = JSON.debugDescription
        
        expect(randomUsernameResponse).toNot(beNil())
        expect(randomUsernameResponse).to(equal("coolrandomusername123"))
        
    }
    
}

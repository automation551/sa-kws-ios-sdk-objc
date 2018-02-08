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



class RandomUsername_DoRandomUsernameFetch_MappingTests : XCTestCase {
    
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
        
        //note that the response for Random Username is a plain string
        //a `fake` mocked response was added in a JSON format
        
        let randomUsernameFakeResponse = try? RandomUsernameFakeResponse.decode(JSON!)
        
        expect(randomUsernameFakeResponse).toNot(beNil())
        expect(randomUsernameFakeResponse?.randomUsername).to(equal("coolrandomusername123"))
        
    }
    
    func test_RandomUsername_DoRandomUsernameFetch_NotFound_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let notFoundResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(notFoundResponse).toNot(beNil())
        expect(notFoundResponse?.code).to(equal(123))
        expect(notFoundResponse?.codeMeaning).to(equal("notFound"))
        
    }
    
}

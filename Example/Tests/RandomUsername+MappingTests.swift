//
//  RandomUsername+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class RandomUsernameMappingTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //Random Username fetch mapping
    func test_RandomUsername_Do_Random_Username_Fetch_Response_Success() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"random_username_success_response")
        
        //note that the response for Random Username is a plain string
        //To bypass that, a `fake` mocked response was added in a JSON format with name `RandomUsernameFakeResponse`
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let randomUsernameFakeResponse = try? JSONDecoder().decode(RandomUsernameFakeResponse.self, from: jsonData!)
        
        expect(randomUsernameFakeResponse).toNot(beNil())
        expect(randomUsernameFakeResponse?.randomUsername).to(equal("coolrandomusername123"))
    }
    
    func test_RandomUsername_Do_Random_Username_Fetch_Not_Found_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
    }
}

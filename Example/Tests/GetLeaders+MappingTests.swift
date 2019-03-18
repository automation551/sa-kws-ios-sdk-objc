//
//  GetLeaders+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 10/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class GetLeadersMappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Scoring_GetLeaders_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"get_leaders_success_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let leadersResponse = try? JSONDecoder().decode(LeadersWrapper.self, from: jsonData!)
        
        expect(leadersResponse).toNot(beNil())
        
        expect(leadersResponse?.results).toNot(beNil())
        expect(leadersResponse?.results[0].name).to(equal("testuser9112"))
        expect(leadersResponse?.results[0].score).to(equal(540))
        expect(leadersResponse?.results[0].rank).to(equal(1))
        
        expect(leadersResponse?.results[1].name).to(equal("testusr472"))
        expect(leadersResponse?.results[1].score).to(equal(40))
        expect(leadersResponse?.results[1].rank).to(equal(2))
        
        expect(leadersResponse?.count).to(equal(2))
        expect(leadersResponse?.offset).to(equal(0))
        expect(leadersResponse?.limit).to(equal(1000))
    }
    
    func test_Scoring_GetLeaders_Mapping_BadToken_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        //401
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_Scoring_GetLeaders_Mapping_BadClientId_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //403
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this client"))
    }
}

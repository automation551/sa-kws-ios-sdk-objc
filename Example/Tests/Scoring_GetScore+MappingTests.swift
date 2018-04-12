//
//  Scoring_GetScore+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 10/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class Scoring_GetScore_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Scoring_GetScore_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"get_user_score_success_response")
        
        let getScoreResponse = try? Score.decode(JSON!)
        
        expect(getScoreResponse).toNot(beNil())
        expect(getScoreResponse?.score).to(equal(600))
        expect(getScoreResponse?.rank).to(equal(1))
    }
    
    func test_Scoring_GetScore_Mapping_BadToken_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //401
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_Scoring_GetScores_Mapping_BadClientId_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //403
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this client"))
    }
}

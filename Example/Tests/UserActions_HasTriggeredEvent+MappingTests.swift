//
//  UserActions_HasTriggeredEvent+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//


import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class UserActions_HasTriggeredEvent_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UserActions_HasTriggeredEvent_Mapping_ResponseSuccess() {
        
        let JSON: Any? = try? fixtureWithName(name:"has_triggered_event_success_response")
        
        let response = try? HasTriggeredEvent.decode(JSON!)
        
        expect(response).toNot(beNil())
        expect(response?.hasTriggeredEvent).to(beTrue())        
    }
    
    func test_UserActions_HasTriggeredEvent_Mapping_BadToken_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //401
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_UserActions_HasTriggeredEvent_Mapping_BadUserId_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //403
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this user"))
    }
    
    func test_UserActions_HasTriggeredEvent_Mapping_BadEventId_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"generic_event_not_found_response")
        
        //400
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(2))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        expect(errorResponse?.message).to(equal("event not found"))
    }
}

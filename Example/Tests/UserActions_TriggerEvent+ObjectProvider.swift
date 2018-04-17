//
//  UserActions_TriggerEvent+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class UserActions_TriggerEvent_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var userActionsService: UserActionsServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var points: Int = 20
    private var eventId: String = "8X9QneMSaxU2VzCBJI5YdxRGG7l3GOUw"
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.userActionsService = KWSSDK.getService(value: UserActionsServiceProtocol.self, environment: self.environment)
    }
    
    override func tearDown() {
        super.tearDown()
        userActionsService = nil
        environment = nil
    }
    
    func test_UserActions_InviteUser_ValidRequestAndResponse(){
        
        let JSON: Any? = ["{}"]
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.eventId,
                                                 points: self.points,
                                                 userId: self.goodUserId,
                                                 token: self.goodToken,
                                                 completionHandler:  { error in
                                                
                                                expect(error).to(beNil())
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_InviteUser_BadTokenResponse(){
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.eventId,
                                                 points: self.points,
                                                 userId: self.goodUserId,
                                                 token: self.badToken,
                                                 completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).errorCode).to(equal("invalid_token"))
                                                expect((error as! ErrorWrapper).error).to(equal("The access token provided is invalid."))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_SetAppData_BadUserIdResponse(){
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.eventId,
                                                 points: self.points,
                                                 userId: self.badUserId,
                                                 token: self.goodToken,
                                                 completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(1))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorWrapper).message).to(equal("operation not supported for this user"))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_TriggerEvent_Mapping_EmptyEventId_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"trigger_event_token_not_valid_response")
        
        //when
        stub(everything , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: "",
                                                 points: self.points,
                                                 userId: self.badUserId,
                                                 token: self.goodToken,
                                                 completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                    expect((error as! ErrorWrapper).code).to(equal(5))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorWrapper).message).to(equal("child \"token\" fails because [\"token\" is not allowed to be empty]"))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_TriggerEvent_Mapping_EventNotFound_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"generic_event_not_found_response")
        
        //when
        stub(everything , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: "",
                                                 points: self.points,
                                                 userId: self.badUserId,
                                                 token: self.goodToken,
                                                 completionHandler:  { error in
                                                    
                                                    expect(error).toNot(beNil())
                                                    expect((error as! ErrorWrapper).code).to(equal(2))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                                                    expect((error as! ErrorWrapper).message).to(equal("event not found"))
                                                    
                                                    done()
            })
        }
    }
    
    func test_UserActions_TriggerEvent_Mapping_TokenReachedUserLimit_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"trigger_event_token_reached_user_limit_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: "",
                                                 points: self.points,
                                                 userId: self.badUserId,
                                                 token: self.goodToken,
                                                 completionHandler:  { error in
                                                    
                                                    expect(error).toNot(beNil())
                                                    expect((error as! ErrorWrapper).code).to(equal(1))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                    expect((error as! ErrorWrapper).message).to(equal("Token reached user limit"))
                                                    
                                                    done()
            })
        }
    }
}


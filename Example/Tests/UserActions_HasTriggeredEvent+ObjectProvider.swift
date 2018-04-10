//
//  UserActions_HasTriggeredEvent+ObjectProvider.swift
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

class UserActions_HasTriggeredEvent_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var userActionsService: UserActionsServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var eventId: Int = 802
    
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
        
        let JSON = try? fixtureWithName(name:"has_triggered_event_success_response")
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.userActionsService.hasTriggeredEvent(eventId: self.eventId,
                                                      userId: self.goodUserId,
                                                      token: self.goodToken,
                                                      completionHandler:{ (hasTriggeredEventResponse, error) in
                                                    
                                                        expect(hasTriggeredEventResponse).toNot(beNil())
                                                        expect(hasTriggeredEventResponse?.hasTriggeredEvent).to(beTrue())
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
            
            self.userActionsService.hasTriggeredEvent(eventId: self.eventId,
                                                      userId: self.goodUserId,
                                                      token: self.badToken,
                                                      completionHandler:{ (hasTriggeredEventResponse, error) in
                                                    
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
            
            self.userActionsService.hasTriggeredEvent(eventId: self.eventId,
                                                      userId: self.badUserId,
                                                      token: self.goodToken,
                                                      completionHandler:{ (hasTriggeredEventResponse, error) in
                                                    
                                                    expect(error).toNot(beNil())
                                                    expect((error as! ErrorWrapper).code).to(equal(1))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                    expect((error as! ErrorWrapper).message).to(equal("operation not supported for this user"))
                                                    
                                                    done()
            })
        }
    }
    
    func test_UserActions_TriggerEvent_Mapping_EventNotFound_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"generic_event_not_found_response")
        
        //when
        stub(everything , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userActionsService.hasTriggeredEvent(eventId: self.eventId,
                                                      userId: self.goodUserId,
                                                      token: self.goodToken,
                                                      completionHandler:{ (hasTriggeredEventResponse, error) in
                                                    
                                                    expect(error).toNot(beNil())
                                                    expect((error as! ErrorWrapper).code).to(equal(2))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                                                    expect((error as! ErrorWrapper).message).to(equal("event not found"))
                                                    
                                                    done()
            })
        }
    }
}

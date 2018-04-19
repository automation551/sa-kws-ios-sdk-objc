//
//  UserActions+ServiceTests.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 19/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class UserActionsServiceTests: XCTestCase {
    
    //class or data to test
    private var userActionsService: UserActionsServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
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
    
    
    //MARK: PERMISSIONS
    
    private var goodPermissions: [String] = ["mock_permission"]
    private var badPermissions: [String] = [""]
    
    func test_UserActions_Permissions_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_success_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken,
                                         permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 204))
        
        waitUntil { done in
            
            self.userActionsService.requestPermissions(permissions: self.goodPermissions,
                                                userId: self.goodUserId,
                                                token: self.goodToken,
                                                completionHandler: { error in
                                                    
                                                    expect(error).to(beNil())
                                                    
                                                    done()
            })
        }
    }
    
    func test_UserActions_Permissions_Required_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_permission_required_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken,
                                         permissionsList: badPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 400))
        
        waitUntil { done in
            self.userActionsService.requestPermissions(permissions: self.badPermissions,
                                                userId: self.goodUserId,
                                                token: self.goodToken,
                                                completionHandler: {  error in
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorWrapper).code).to(equal(5))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorWrapper).message).to(equal("child \"permissions\" fails because [\"permissions\" is required]"))
                                                    expect((error as! ErrorWrapper).invalid?.permissions).toNot(beNil())
                                                    expect((error as! ErrorWrapper).invalid?.permissions?.code).to(equal(6))
                                                    expect((error as! ErrorWrapper).invalid?.permissions?.codeMeaning).to(equal("missing"))
                                                    expect((error as! ErrorWrapper).invalid?.permissions?.message).to(equal("\"permissions\" is required"))
                                                    
                                                    
                                                    done()
            })
        }
    }
    
    func test_UserActions_Permissions_Not_Supported_For_User_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: badUserId,
                                         token: goodToken,
                                         permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 403))
        
        waitUntil { done in
            self.userActionsService.requestPermissions(permissions: self.goodPermissions,
                                                userId: self.badUserId,
                                                token: self.goodToken,
                                                completionHandler: { error in
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorWrapper).code).to(equal(1))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                    expect((error as! ErrorWrapper).message).to(equal("operation not supported for this user"))
                                                    
                                                    done()
            })
        }
    }
    
    func test_UserActions_Permissions_Requested_Not_Found_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_not_found_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken,
                                         permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 404))
        
        waitUntil { done in
            self.userActionsService.requestPermissions(permissions: self.goodPermissions,
                                                userId: self.goodUserId,
                                                token: self.goodToken,
                                                completionHandler: { error in
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorWrapper).code).to(equal(2))
                                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                                                    expect((error as! ErrorWrapper).message).to(equal("permissions not found: mock_permission"))
                                                    
                                                    done()
            })
        }
    }
    
    //MARK: HAS TRIGGERED EVENT
    
    private var eventId: Int = 802
    
    func test_UserActions_HasTriggeredEvent_ValidRequestAndResponse(){
        
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
    
    func test_UserActions_HasTriggeredEvent_BadToken_Response(){
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
    
    func test_UserActions_HasTriggered_BadUserId_Response(){
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
    
    func test_UserActions_HasTriggeredEvent_EventNotFound_Response() {
        
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
    
    //MARK: TRIGGER EVENT
    
    private var points: Int = 20
    private var triggerEventId: String = "8X9QneMSaxU2VzCBJI5YdxRGG7l3GOUw"
    
    func test_UserActions_TriggerEvent_ValidRequestAndResponse(){
        
        let JSON: Any? = ["{}"]
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.triggerEventId,
                                                 points: self.points,
                                                 userId: self.goodUserId,
                                                 token: self.goodToken,
                                                 completionHandler:  { error in
                                                    
                                                    expect(error).to(beNil())
                                                    
                                                    done()
            })
        }
    }
    
    func test_UserActions_TriggerEvent_BadToken_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.triggerEventId,
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
    
    func test_UserActions_TriggerEvent_BadUserId_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.triggerEventId,
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
    
    func test_UserActions_TriggerEvent_EmptyEventId_Response() {
        
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
    
    func test_UserActions_TriggerEvent_EventNotFound_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"generic_event_not_found_response")
        
        //when
        stub(everything , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.triggerEventId,
                                                 points: self.points,
                                                 userId: self.goodUserId,
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
    
    func test_UserActions_TriggerEvent_TokenReachedUserLimit_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"trigger_event_token_reached_user_limit_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.triggerEvent(eventId: self.triggerEventId,
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
    
    //MARK: SET APP DATA
    
    private var value: Int = 1
    private var nameKey: String = "name_key"   
    
    func test_UserActions_SetAppData_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"set_app_data_fake_success_response")
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.userActionsService.setAppData(value: self.value,
                                               key: self.nameKey,
                                               userId: self.goodUserId,
                                               appId: self.goodAppId,
                                               token: self.goodToken, completionHandler:  { error in
                                                
                                                expect(error).to(beNil())
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_SetAppData_EmptyNameKey_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"set_app_data_empty_name_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.userActionsService.setAppData(value: self.value,
                                               key: "",
                                               userId: self.goodUserId,
                                               appId: self.goodAppId,
                                               token: self.goodToken, completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(5))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                                                expect((error as! ErrorWrapper).message).to(equal("child \"name\" fails because [\"name\" is not allowed to be empty]"))
                                                expect((error as! ErrorWrapper).invalid).toNot(beNil())
                                                expect((error as! ErrorWrapper).invalid?.nameKey?.code).to(equal(7))
                                                expect((error as! ErrorWrapper).invalid?.nameKey?.codeMeaning).to(equal("invalidValue"))
                                                expect((error as! ErrorWrapper).invalid?.nameKey?.message).to(equal("\"name\" is not allowed to be empty"))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_SetAppData_BadToken_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.userActionsService.setAppData(value: self.value,
                                               key: "",
                                               userId: self.goodUserId,
                                               appId: self.goodAppId,
                                               token: self.goodToken, completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).errorCode).to(equal("invalid_token"))
                                                expect((error as! ErrorWrapper).error).to(equal("The access token provided is invalid."))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_SetAppData_BadUserId_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.setAppData(value: self.value,
                                               key: self.nameKey,
                                               userId: self.goodUserId,
                                               appId: self.badAppId,
                                               token: self.goodToken, completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(1))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorWrapper).message).to(equal("operation not supported for this user"))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_SetAppData_BadClientId_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.setAppData(value: self.value,
                                               key: self.nameKey,
                                               userId: self.goodUserId,
                                               appId: self.badAppId,
                                               token: self.goodToken, completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(1))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorWrapper).message).to(equal("operation not supported for this client"))
                                                
                                                done()
            })
        }
    }
    
    //MARK: GET APP DATA
    
    private var goodAppId: Int = 1
    private var badAppId: Int = -1    
    
    func test_UserActions_GetAppData_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"get_app_data_success_response")
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.userActionsService.getAppData(userId: self.goodUserId,
                                               appId: self.goodAppId,
                                               token: self.goodToken,
                                               completionHandler: { appData, error in
                                                
                                                expect(appData?.results.count).to(equal(4))
                                                expect(appData?.count).to(equal(4))
                                                expect(appData?.offset).to(equal(0))
                                                expect(appData?.limit).to(equal(1000))
                                                expect(error).to(beNil())
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_GetAppData_BadToken_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything, json(JSON!, status:401))
        
        waitUntil { done in
            
            self.userActionsService.getAppData(userId: self.goodUserId,
                                               appId: self.goodAppId,
                                               token: self.badToken,
                                               completionHandler: { appData, error in
                                                
                                                expect(appData).to(beNil())
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).errorCode).to(equal("invalid_token"))
                                                expect((error as! ErrorWrapper).error).to(equal("The access token provided is invalid."))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_GetAppData_BadUserId_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        //when
        stub(everything , json(JSON!, status:403))
        
        waitUntil { done in
            
            self.userActionsService.getAppData(userId: self.badUserId,
                                               appId: self.goodAppId,
                                               token: self.goodToken,
                                               completionHandler: { appData, error in
                                                
                                                expect(appData).to(beNil())
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(1))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorWrapper).message).to(equal("operation not supported for this user"))
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_GetAppData_BadAppId_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //when
        stub(everything, json(JSON!, status:403))
        
        waitUntil { done in
            
            self.userActionsService.getAppData(userId: self.goodUserId,
                                               appId: self.badAppId,
                                               token: self.goodToken,
                                               completionHandler: { appData, error in
                                                
                                                expect(appData).to(beNil())
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(1))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorWrapper).message).to(equal("operation not supported for this client"))
                                                
                                                done()
            })
        }
    }
    
    //MARK: INVITE USER
    
    private var emailAddress: String = "john.doe@email.com"
    
    func test_UserActions_InviteUser_ValidRequestAndResponse(){
        
        let JSON: Any? = ["{}"]
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.userActionsService.inviteUser(email: self.emailAddress,
                                               userId: self.goodUserId,
                                               token: self.goodToken,
                                               completionHandler:  { error in
                                                
                                                expect(error).to(beNil())
                                                
                                                done()
            })
        }
    }
    
    func test_UserActions_InviteUser_BadToken_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.userActionsService.inviteUser(email: self.emailAddress,
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
    
    func test_UserActions_InviteUser_BadUserId_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.inviteUser(email: self.emailAddress,
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
    
    func test_User_Actions_InviteUser_BadEmail_Response() {
        
        let JSON: Any? = try? fixtureWithName(name:"invite_user_bad_email_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userActionsService.inviteUser(email: "",
                                               userId: self.badUserId,
                                               token: self.goodToken,
                                               completionHandler:  { error in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(5))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                                                expect((error as! ErrorWrapper).message).to(equal("child \"email\" fails because [\"email\" must be a valid email]"))
                                                
                                                done()
            })
        }
    }
    
}

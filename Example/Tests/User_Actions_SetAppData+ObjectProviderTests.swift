//
//  User_Actions_SetAppData+ObjectProviderTests.swift
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

class User_Actions_GetAppData_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var userActionsService: UserActionsServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var goodAppId: Int = 1
    private var badAppId: Int = -1
    
    private var value: Int = 1
    private var nameKey: String = "name_key"    
    
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
    
    func test_UserActions_SetAppData_EmptyNameKey(){
        
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
    
    func test_UserActions_SetAppData_BadTokenResponse(){
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
    
    func test_UserActions_SetAppData_BadUserIdResponse(){
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
    
    func test_UserActions_SetAppData_BadClientIdResponse(){
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
}

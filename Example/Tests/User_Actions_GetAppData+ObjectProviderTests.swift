//
//  User_Actions_GetAppData+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/04/2018.
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
    
    func test_test_UserActions_GetAppData_BadToken_Response(){
        
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
    
    func test_test_UserActions_GetAppData_BadUserId_Response(){
        
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
    
    func test_test_UserActions_GetAppData_BadAppId_Response(){
        
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
}

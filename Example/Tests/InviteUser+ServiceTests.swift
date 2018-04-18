//
//  InviteUser+ServiceTests.swift
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

class InviteUserServiceTests: XCTestCase {
    
    //class or data to test
    private var userActionsService: UserActionsServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var emailAddress: String = "john.doe@email.com"
    
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
            
            self.userActionsService.inviteUser(email: self.emailAddress,
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
    
    func test_UserActions_SetAppData_BadUserIdResponse(){
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
    
    func test_User_Actions_InviteUser_Mapping_BadEmail_Response() {
        
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

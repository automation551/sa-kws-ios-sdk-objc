//
//  UserActions_InviteUser+MappingTests.swift
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

class UserActions_InviteUser_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_User_Actions_InviteUser_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = ["{}"]
        
        let inviteUser = try? ErrorWrapper.decode(JSON!)
        
        expect(inviteUser).to(beNil())
    }
    
    func test_User_Actions_InviteUser_Mapping_BadToken_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //401
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_User_Actions_InviteUser_Mapping_BadUserId_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //403
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this user"))
    }
    
    func test_User_Actions_InviteUser_Mapping_BadEmail_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"invite_user_bad_email_response")
        
        //403
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"email\" fails because [\"email\" must be a valid email]"))
        expect(errorResponse?.invalid?.email).toNot(beNil())
        expect(errorResponse?.invalid?.email?.code).to(equal(7))
        expect(errorResponse?.invalid?.email?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.email?.message).to(equal("\"email\" must be a valid email"))
    }
}

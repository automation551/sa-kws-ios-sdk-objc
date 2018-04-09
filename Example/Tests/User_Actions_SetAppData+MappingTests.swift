//
//  User_Actions_SetAppData+MappingTests.swift
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

class User_Actions_SetAppData_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_User_Actions_setAppData_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"set_app_data_fake_success_response")
        
        let setAppDataResponse = try? SetAppDataFakeResponse.decode(JSON!)
        
        expect(setAppDataResponse).toNot(beNil())
        expect(setAppDataResponse?.appSet).to(beTrue())
    }
    
    func test_User_Actions_SetAppData_Mapping_EmptyName_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"set_app_data_empty_name_response")
        
        //403
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"name\" fails because [\"name\" is not allowed to be empty]"))
        expect(errorResponse?.invalid).toNot(beNil())
        expect(errorResponse?.invalid?.nameKey?.code).to(equal(7))
        expect(errorResponse?.invalid?.nameKey?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.nameKey?.message).to(equal("\"name\" is not allowed to be empty"))
    }
    
    func test_User_Actions_SetAppData_Mapping_BadToken_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //401
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_User_Actions_SetAppData_Mapping_BadUserId_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        //403
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this user"))
    }
    
    func test_User_Actions_SetAppData_Mapping_BadClientId_Response() {
        
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


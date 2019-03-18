//
//  GetAppData+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class GetAppDataMappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_User_Actions_GetAppData_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"get_app_data_success_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let appDataResponse = try? JSONDecoder().decode(AppDataWrapper.self, from: jsonData!)
        
        expect(appDataResponse).toNot(beNil())
        expect(appDataResponse?.results.count).to(equal(4))
        expect(appDataResponse?.count).to(equal(4))
        expect(appDataResponse?.offset).to(equal(0))
        expect(appDataResponse?.limit).to(equal(1000))
    }
    
    func test_User_Actions_GetAppData_Mapping_BadToken_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        //401
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_User_Actions_GetAppData_Mapping_BadUserId_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        //403
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this user"))
    }
    
    func test_User_Actions_GetAppData_Mapping_BadClientId_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //403
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this client"))
    }
}

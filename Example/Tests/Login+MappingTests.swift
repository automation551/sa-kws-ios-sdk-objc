//
//  Login+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class Login_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_Login_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"login_success_response")
        
        let loginResponse = try? AuthResponse.decode(JSON!)
        
        expect(loginResponse).toNot(beNil())
        expect(loginResponse?.token).to(equal("good_token"))
        
    }
    
   
    func test_Login_Mapping_ErrorResponse_BadClientCredentials(){
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_client"))
        expect(errorResponse?.error).to(equal("Client credentials are invalid"))
        
    }
    
    func test_Login_Mapping_ErrorResponse_BadUserCredentials(){
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_grant"))
        expect(errorResponse?.error).to(equal("User credentials are invalid"))
        
    }
    
    
    func test_Login_Mapping_ErrorResponse_NotFound() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        
    }
    
}

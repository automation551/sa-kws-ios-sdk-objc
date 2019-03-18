//
//  Login+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class LoginMappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Login_Mapping_ResponseSuccess() {
        
        let JSON = try? fixtureWithName(name:"login_success_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let loginResponse = try? JSONDecoder().decode(LoginAuthResponseModel.self, from: jsonData!)
        
        expect(loginResponse).toNot(beNil())
        expect(loginResponse?.token).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOjUwNzMsImFwcElkIjozNTgsImNsaWVudElkIjoia3dzLXNkay10ZXN0aW5nIiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTI0NTU4NzY3LCJleHAiOjE4Mzk5MTg3NjcsImlzcyI6InN1cGVyYXdlc29tZSJ9.Is_paGut_gq7Zo5r0eWcH4GI3BCA8-eFiFurrb080O0xY0GWo2SIIR5FKf4_iDNVy_LM0x4j5kzDowl5gOZ7O3-KelA9MO6mpADl6eyVA109Z3ij3uZZU_Y7HRoA8XFL_TgUq_I7ZcpiXFhf4kzUEVEstkaBpEJXOFfcr9SedG7HD6r94zNKVaRGbS1x9Y8eOCdQf1ainizl0MEjjU7LFjUXv4eOc9Vj57N9oVEY2_cqd0No5Sa0sPUZaEVSuRQDR78dhBuLJKttgovGFdJZj7YgLOmjPaFvqHkpuS50h2oh_YP-v-gzSFItRPWqtDOIyHSMLOvoOb8-FeptveBXsw"))
    }
    
   
    func test_Login_Mapping_ErrorResponse_BadClientCredentials(){
        
        let JSON = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_client"))
        expect(errorResponse?.error).to(equal("Client credentials are invalid"))
    }
    
    func test_Login_Mapping_ErrorResponse_BadUserCredentials(){
        
        let JSON = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_grant"))
        expect(errorResponse?.error).to(equal("User credentials are invalid"))
    }
    
    func test_Login_Mapping_ErrorResponse_NotFound() {
    
        let JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
    }
}

//
//  AppConfig+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class AppConfigMappingTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //App Config mapping
    func test_Random_Username_App_Config_Response_Success() {
        
        let JSON = try? fixtureWithName(name:"app_config_success_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let appConfigResponse = try? JSONDecoder().decode(AppConfigWrapper.self, from: jsonData!)
        
        expect(appConfigResponse).toNot(beNil())
        expect(appConfigResponse?.app.id).to(equal(358))
        expect(appConfigResponse?.app.name).to(equal("good_name"))
    }
    
    func test_Random_Username_App_Config_Nil_Auth_Client_Id_Response (){

        let JSON = try? fixtureWithName(name:"app_config_null_oauthclientid_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is required]"))
        expect(errorResponse?.invalid?.oauthClientId?.code).to(equal(6))
        expect(errorResponse?.invalid?.oauthClientId?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.oauthClientId?.message).to(equal("\"oauthClientId\" is required"))
    }
    
    func test_Random_Username_App_Config_Empty_Auth_Client_Id_Response (){
        
        let JSON = try? fixtureWithName(name:"app_config_empty_oauthclientid_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is not allowed to be empty]"))
        expect(errorResponse?.invalid?.oauthClientId?.code).to(equal(7))
        expect(errorResponse?.invalid?.oauthClientId?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.oauthClientId?.message).to(equal("\"oauthClientId\" is not allowed to be empty"))
    }
    
    func test_Random_Username_App_Config_App_Not_Found_Response (){
        
        let JSON = try? fixtureWithName(name:"app_config_app_not_found_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(2))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        expect(errorResponse?.message).to(equal("app not found."))
    }
    
    func test_Random_Username_App_Config_Generic_Not_Found_Response() {
        
        let JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
    }
}

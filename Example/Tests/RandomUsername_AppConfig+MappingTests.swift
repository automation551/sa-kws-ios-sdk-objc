//
//  RandomUsername_AppConfig+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class RandomUsername_AppConfig_MappingTests : XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //App Config mapping
    func test_RandomUsername_AppConfig_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"app_config_success_response")
        
        let appConfigResponse = try? AppConfigWrapper.decode(JSON!)
        
        expect(appConfigResponse).toNot(beNil())
        expect(appConfigResponse?.app.id).to(equal(2))
        expect(appConfigResponse?.app.name).to(equal("good_name"))
    }
    
    func test_RandomUsername_AppConfig_NilAuthClientId_Response (){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"app_config_null_oauthclientid_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is required]"))
        expect(errorResponse?.invalid?.oauthClientId?.code).to(equal(6))
        expect(errorResponse?.invalid?.oauthClientId?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.oauthClientId?.errorMessage).to(equal("\"oauthClientId\" is required"))
    }
    
    func test_RandomUsername_AppConfig_Empty_AuthClientId_Response (){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"app_config_empty_oauthclientid_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is not allowed to be empty]"))
        expect(errorResponse?.invalid?.oauthClientId?.code).to(equal(7))
        expect(errorResponse?.invalid?.oauthClientId?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.oauthClientId?.errorMessage).to(equal("\"oauthClientId\" is not allowed to be empty"))
    }
    
    func test_RandomUsername_AppConfig_AppNotFound_Response (){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"app_config_app_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(2))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        expect(errorResponse?.errorMessage).to(equal("app not found."))
    }
    
    func test_RandomUsername_DoRandomUsernameFetch_NotFound_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
    }
}

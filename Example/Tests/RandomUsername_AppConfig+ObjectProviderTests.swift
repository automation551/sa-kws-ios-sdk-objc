//
//  RandomUsername_AppConfig+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase


class RandomUsername_AppConfig_ObjectProviderTests : XCTestCase{
    
    /*
     Random Username is a 2 step process - this is step 1
     The test here should be to test the provider through the Service (see Login Provider Test)
     In order to keep each step of create user tested individually, this test uses the UsernameProvider resource
     instead of using RandomUsernameService
     */
    
    
    // class or data to test
    private var resource: RandomUsernameProvider!
    private var environment: KWSNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        resource = RandomUsernameProvider.init(environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        resource = nil
        environment = nil
    }
    
    func test_RandomUsername_AppConfig_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name: "app_config_success_response")
        
        let request = AppConfigRequest(environment: self.environment,
                                       clientID: self.environment.mobileKey)
        
        let uri = "\(request.environment.domain + request.endpoint + "?oauthClientId=" + self.environment.mobileKey)"

        stub(http(.get, uri: uri), json(JSON!))
        
        waitUntil { done in
        
            self.resource.getAppConfigDetails(environment: self.environment, callback: { response, error in

                //then
                expect(response).toNot(beNil())
                
                expect(response?.app?.id).to(equal(2))
                expect(response?.app?.name).to(equal("good_name"))

                expect(error).to(beNil())
                
                done()
            })

        }
        
    }
    
    func test_RandomUsername_AppConfig_NilOAuthClient_Response(){
        
        let JSON: Any? = try? fixtureWithName(name: "app_config_null_oauthclientid_response")
        
        let request = AppConfigRequest(environment: self.environment,
                                       clientID: self.environment.mobileKey)
        
        let uri = "\(request.environment.domain + request.endpoint + "?oauthClientId=" + self.environment.mobileKey)"
        
        stub(http(.get, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.resource.getAppConfigDetails(environment: self.environment, callback: { response, error in
                
                //then
                expect(response).to(beNil())
            
                expect(error).toNot(beNil())
                
                expect((error as! ErrorResponse).code).to(equal(5))
                expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                expect((error as! ErrorResponse).errorMessage).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is required]"))
                expect((error as! ErrorResponse).invalid?.oauthClientId?.code).to(equal(6))
                expect((error as! ErrorResponse).invalid?.oauthClientId?.codeMeaning).to(equal("missing"))
                expect((error as! ErrorResponse).invalid?.oauthClientId?.errorMessage).to(equal("\"oauthClientId\" is required"))
                
                done()
            })
            
        }
        
    }
    
    
    func test_RandomUsername_AppConfig_EmptyOAuthClient_Response(){
        
        let JSON: Any? = try? fixtureWithName(name: "app_config_empty_oauthclientid_response")
        
        let request = AppConfigRequest(environment: self.environment,
                                       clientID: self.environment.mobileKey)
        
        let uri = "\(request.environment.domain + request.endpoint + "?oauthClientId=" + self.environment.mobileKey)"
        
        stub(http(.get, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.resource.getAppConfigDetails(environment: self.environment, callback: { response, error in
                
                //then
                expect(response).to(beNil())
                
                expect(error).toNot(beNil())
                
                expect((error as! ErrorResponse).code).to(equal(5))
                expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                expect((error as! ErrorResponse).errorMessage).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is not allowed to be empty]"))
                expect((error as! ErrorResponse).invalid?.oauthClientId?.code).to(equal(7))
                expect((error as! ErrorResponse).invalid?.oauthClientId?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorResponse).invalid?.oauthClientId?.errorMessage).to(equal("\"oauthClientId\" is not allowed to be empty"))
                done()
            })
            
        }
        
    }
    
    
    func test_RandomUsername_AppConfig_AppNotFound_Response(){
        
        let JSON: Any? = try? fixtureWithName(name: "app_config_app_not_found_response")
        
        let request = AppConfigRequest(environment: self.environment,
                                       clientID: self.environment.mobileKey)
        
        let uri = "\(request.environment.domain + request.endpoint + "?oauthClientId=" + self.environment.mobileKey)"
        
        stub(http(.get, uri: uri), json(JSON!, status: 404 ))
        
        waitUntil { done in
            
            self.resource.getAppConfigDetails(environment: self.environment, callback: { response, error in
                
                //then
                expect(response).to(beNil())
                
                expect(error).toNot(beNil())
                
                expect((error as! ErrorResponse).code).to(equal(2))
                expect((error as! ErrorResponse).codeMeaning).to(equal("notFound"))
                expect((error as! ErrorResponse).errorMessage).to(equal("app not found."))
                
                done()
            })
            
        }
        
    }
    
    
}

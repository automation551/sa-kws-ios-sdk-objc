//
//  CreateUser_TempAccessToken+ObjectProviderTests.swift
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


class CreateUser_TempAccessToken_ObjectProviderTests: XCTestCase {
    
    
    /*
     Create User is a 2 step process - this is step 1
     The test here should be to test the provider through the Service (see Login Provider Test)
     In order to keep each step of create user tested individually, this test uses the CreateUserProvider resource
     instead of using CreateUserService
     */
    
    //class or data to test
    private var createUserResource: CreateUserProvider!
    private var environment: KWSNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        createUserResource = CreateUserProvider.init(environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        createUserResource = nil
        environment = nil
    }
    

    //Temp Access Token
    func test_TempAccessToken_Valid_RequestAndResponse() {
        
        let JSON: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        
        let request = TempAccessTokenRequest(environment: self.environment,
                                             clientID: self.environment.mobileKey,
                                             clientSecret: self.environment.appID)
        
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri), json(JSON!))
        
        waitUntil { done in
            
            self.createUserResource.getTempAccessToken(environment: self.environment,
                                                       callback: { tempAccessTokenResponse, error in
                                                        
                                                        expect(tempAccessTokenResponse).toNot(beNil())
                                                        expect(tempAccessTokenResponse?.token).to(equal("good_token"))
                                                        expect(error).to(beNil())
                                                        done()
                                                        
            })
        }
        
    }
    
    func test_TempAccessToken_BadGrantType_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "generic_missing_grant_type_response")
        
        let request = TempAccessTokenRequest(environment: self.environment,
                                             clientID: "123",
                                             clientSecret: "321")
        
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.getTempAccessToken(environment: self.environment,
                                                       callback: { tempAccessTokenResponse, error in
                                                        
                                                        expect(tempAccessTokenResponse).to(beNil())
                                                        
                                                        expect(error).toNot(beNil())
                                                      
                                                        expect((error as! ErrorResponse).errorCode).to(equal("invalid_request"))
                                                        expect((error as! ErrorResponse).error).to(equal("Invalid or missing grant_type parameter"))
                                                        done()
                                                        
            })
        }
        
    }
    
    
    func test_TempAccessToken_BadClientCredentials_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "generic_bad_client_credentials_response")
        
        let request = TempAccessTokenRequest(environment: self.environment,
                                             clientID: "123",
                                             clientSecret: "321")
        
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.getTempAccessToken(environment: self.environment,
                                                       callback: { tempAccessTokenResponse, error in
                                                        
                                                        expect(tempAccessTokenResponse).to(beNil())
                                                        
                                                        expect(error).toNot(beNil())
                                                        
                                                        expect((error as! ErrorResponse).errorCode).to(equal("invalid_client"))
                                                        expect((error as! ErrorResponse).error).to(equal("Client credentials are invalid"))
                                                        done()
                                                        
            })
        }
        
    }
    

}

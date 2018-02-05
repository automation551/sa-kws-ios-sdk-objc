//
//  CreateUser+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class CreateUser_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var createUserResource: CreateUserProvider!
    
    private var request: CreateUserRequest!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUsername: String = "good_username"
    private var badUsername: String = "bad_username"
    
    private var goodPassword: String = "good_password"
    private var badPassword: String = "bad_password"
    
    private var goodDOB: String = "good_dob"
    private var badDOB: String = "bad_dob"
    
    private var goodCountry: String = "good_country"
    private var badCountry: String = "bad_country"
    
    private var goodParentEmail: String = "good_@_email"
    private var badParentEmail: String = "bad_@_email"
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var badClientID: String = "bad_client_id"
    private var badClientSecret: String = "bad_client_secret"
    
    private var goodAppID: Int = 1
    private var badAppID: Int = -1
    
    
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
        request = nil
        environment = nil
    }
    
    
    func testCreateUserRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"create_user_success_response")
        
        request = CreateUserRequest(environment: self.environment,
                                    username: goodUsername,
                                    password: goodPassword,
                                    dateOfBirth: goodDOB,
                                    country: goodCountry,
                                    parentEmail: goodParentEmail,
                                    token: goodToken,
                                    appID: goodAppID)
        
        //when
//        stub(http(.post, uri: request.environment.domain + request.endpoint + "?access_token=good_token") , json(JSON!))
        
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint + "?access_token=good_token")") , json(JSON!))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token:self.goodToken,
                                                   callback: {  createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).toNot(beNil())
                                                    expect(createUserResponse?.id).to(equal(99))
                                                    expect(createUserResponse?.token).to(equal(self.goodToken))
                                                    
                                                    expect(error).to(beNil())
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    
    
    func testCreateUserGetTempTokenRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"temp_access_token_success_response")
        
        let requesty = TempAccessTokenRequest(environment: self.environment,
                                         clientID: self.environment.mobileKey,
                                         clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: "\(requesty.environment.domain + requesty.endpoint)") , json(JSON!))
        
        waitUntil { done in
            
            self.createUserResource.getTempAccessToken(environment: self.environment,
                                                   callback: {  authResponse, error in
                                                    
                                                    //then
                                                    expect(authResponse).toNot(beNil())
                                                
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}

//
//  Login+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class Login_ObjectProviderTests: XCTestCase {
    
    // class or data to test
    private var loginService: LoginService!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUsername: String = "good_username"
    private var badUsername: String = "bad_username"
    
    private var goodPassword: String = "good_password"
    private var badPassword: String = "bad_password"
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var badClientID: String = "bad_client_id"
    private var badClientSecret: String = "bad_client_secret"
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.loginService = KWSSDK.getService(value: LoginService.self, environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        loginService = nil
        environment = nil
    }
    
    func test_Login_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_success_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: goodPassword,
                                   clientID: self.environment.mobileKey,
                                   clientSecret: self.environment.appID)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            
            self.loginService.loginUser(username: self.goodUsername,
                                        password: self.goodPassword,
                                        callback: {  loginResponse, error in
                                            
                                            //then
                                            expect(loginResponse).toNot(beNil())
                                            expect(loginResponse?.token).to(equal("good_token"))
                                            
                                            expect(error).to(beNil())
                                            
                                            done()
                                            
            })
        }
        
    }
    
    func test_Login_BadHttp_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let  request = LoginRequest(environment: self.environment,
                                    username: goodUsername,
                                    password: goodPassword,
                                    clientID: self.environment.mobileKey,
                                    clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.loginService.loginUser(username: self.goodUsername, password: self.goodPassword, callback: {  loginResponse, error in
                
                //then
                expect(loginResponse).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorResponse).code).to(equal(123))
                expect((error as! ErrorResponse).codeMeaning).to(equal("notFound"))
                
                done()
                
            })
        }
        
    }
    
    func test_Login_BadUsername_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: badUsername,
                                   password: goodPassword,
                                   clientID: self.environment.mobileKey,
                                   clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.loginService.loginUser(username: self.goodUsername, password: self.goodPassword, callback: {  loginResponse, error in
                
                //then
                expect(loginResponse).to(beNil());
                
                expect(error).toNot(beNil());
                expect((error as! ErrorResponse).errorCode).to(equal("invalid_grant"))
                expect((error as! ErrorResponse).error).to(equal("User credentials are invalid"))
                
                done()
                
            })
        }
        
    }
    
    func test_Login_BadPassword_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: badPassword,
                                   clientID: self.environment.mobileKey,
                                   clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.loginService.loginUser(username: self.goodUsername, password: self.goodPassword,callback: { loginResponse, error in
                
                //then
                expect(loginResponse).to(beNil())
                
                expect(error).toNot(beNil());
                expect((error as! ErrorResponse).errorCode).to(equal("invalid_grant"))
                expect((error as! ErrorResponse).error).to(equal("User credentials are invalid"))
                
                done()
                
            })
        }
        
    }
    
    func test_Login_BadClientID_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let  request = LoginRequest(environment: self.environment,
                                    username: goodUsername,
                                    password: goodPassword,
                                    clientID: badClientID,
                                    clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.loginService.loginUser(username: self.goodUsername, password: self.goodPassword, callback: { loginResponse, error in
                
                //then
                expect(loginResponse).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorResponse).errorCode).to(equal("invalid_client"))
                expect((error as! ErrorResponse).error).to(equal("Client credentials are invalid"))
                
                done()
                
            })
        }
        
    }
    
    func test_Login_BadClientSecret_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: goodPassword,
                                   clientID: self.environment.mobileKey,
                                   clientSecret: badClientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.loginService.loginUser(username: self.goodUsername, password: self.goodPassword, callback: { loginResponse, error in
                
                //then
                expect(loginResponse).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorResponse).errorCode).to(equal("invalid_client"))
                expect((error as! ErrorResponse).error).to(equal("Client credentials are invalid"))
                
                done()
                
            })
        }
        
    }
    
    
    
}

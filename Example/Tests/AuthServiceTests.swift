//
//  Auth+ServiceTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 19/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class AuthServiceTests: XCTestCase {
    
    // class or data to test
    private var service: AuthServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    private var goodUsername: String = "good_username"
    private var badUsername: String = "bad_username"
    
    private var goodPassword: String = "good_password"
    private var badPassword: String = "bad_password"
    
    private var goodToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhcHBJZCI6MzU4LCJjbGllbnRJZCI6Imt3cy1zZGstdGVzdGluZyIsInNjb3BlIjoibW9iaWxlQXBwIiwiaWF0IjoxNTI0NDgzMTgxLCJleHAiOjE1MjQ1Njk1ODEsImlzcyI6InN1cGVyYXdlc29tZSJ9.KIzj1aDotN6irP2E9xrmpBgwNVCYkV6f9J3W8LimMtG5Vu6NlV6dIj369ZyWshenmcJ5fXLxIQiGoNizkd_maGGQksRvR5ll1puysP2wEmtPqt9GBmrni8fzc_oQp3T9L_qwnFLkcNTHV0uY1meGttuKja9-1QfU9in-bwtX1G7Fp4KzeVCtt9zYVai1kvQsjGujyiN0zy9MPe9TBYkswQDEP0TcYyH1RsXsFA4Rfxea75yVUbpi7Lv4w1CdAPsl-J9I3G5GxOqumOE1ZTuzbWqjpB03a1xN-ahGXTGc2Gkh184QD8mFe_AVZFQQgUfxLM9IzBNE5rRLG_M41n-Ksg"
    private var badToken: String = "bad_token"
    
    private var badClientID: String = "bad_client_id"
    private var badClientSecret: String = "bad_client_secret"
    
    var dataProvider: AuthService!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvirnoment: self.environment)
        self.service = sdk.getService(withType: AuthServiceProtocol.self)
       
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    //MARK: CREATE USER
    
    func test_Multiple_Stubs(){
        
        let JSON1: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let JSON2: Any? = try? fixtureWithName(name: "create_user_success_response")
        
        let requestTempToken = TempAccessTokenRequest(environment: environment, clientID: environment.clientID, clientSecret: environment.clientSecret)
        
        let requestCreateUser = CreateUserRequest(environment: environment, username: "aa", password: "pwd", dateOfBirth: "2012-02-02", country: "GB", parentEmail: "mail@mail.com", token: self.goodToken, appID: 358)
        
        let uriTemp = "\(requestTempToken.environment.domain + requestTempToken.endpoint)"
        stub(http(.post, uri: uriTemp), json(JSON1!))
//        stub(everything, json(JSON1!))
        
        let uriCreate = "\(requestCreateUser.environment.domain + requestCreateUser.endpoint)"
        stub(http(.post, uri: uriCreate), json(JSON2!))
//       stub(everything, json(JSON2!))
        
        waitUntil { done in
        
            self.service.createUser(username: "aa", password: "pwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "mail@mail.com") { (model, error) in
                
                expect(model).toNot(beNil())
                expect(error).to(beNil())
                
                done()
            }
        }
        
    }
    
    func test_Do_User_Creation_Success(){
        
        //todo add JSON
        let JSON: Any? = try? fixtureWithName(name: "create_user_success_response")
        
        stub(everything, json(JSON!))
        
        if let authService = service as? AuthService {
            
            waitUntil { done in
                
                authService.doUserCreation(environment: self.environment, username: self.goodUsername, password: self.goodPassword, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "mail@mail.com", appId: 123, token: self.goodToken, completionHandler: { (model, error) in
                    
                    //todo expect
                    
                    expect(model).toNot(beNil())
                    expect(error).to(beNil())
                    
                    done()
                })
            }
            
        }
    }
    
   
    
    //MARK: LOGIN
    func test_Login_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_success_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: goodPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: self.environment.clientSecret)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: {  loginResponse, error in
                                    
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
                                    clientID: self.environment.clientID,
                                    clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: {  loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil())
                                    expect((error as! ErrorWrapper).code).to(equal(123))
                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                                    
                                    done()
            })
        }
    }
    
    func test_Login_BadUsername_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: badUsername,
                                   password: goodPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: {  loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil());
                                    
                                    expect(error).toNot(beNil());
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_grant"))
                                    expect((error as! ErrorWrapper).error).to(equal("User credentials are invalid"))
                                    
                                    done()
            })
        }
    }
    
    func test_Login_BadPassword_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: badPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: { loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil());
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_grant"))
                                    expect((error as! ErrorWrapper).error).to(equal("User credentials are invalid"))
                                    
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
                                    clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: { loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil())
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_client"))
                                    expect((error as! ErrorWrapper).error).to(equal("Client credentials are invalid"))
                                    
                                    done()
            })
        }
        
    }
    
    func test_Login_BadClientSecret_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: goodPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: badClientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: { loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil())
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_client"))
                                    expect((error as! ErrorWrapper).error).to(equal("Client credentials are invalid"))
                                    
                                    done()
            })
        }
    }
}

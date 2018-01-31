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
    
    var loginResource: LoginProvider!
    private var request: LoginRequest!
    var environment: KWSNetworkEnvironment!
    
    var goodUsername: String = "good_username"
    var badUsername: String = "bad_username"
    
    var goodPassword: String = "good_password"
    var badPassword: String = "bad_password"
    
    var goodToken: String = "good_token"
    var badToken: String = "bad_token"
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        
        //when
        loginResource = LoginProvider.init(environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_response
        
        let req = LoginRequest(environment: self.environment,
                               username: goodUsername,
                               password: goodPassword,
                               clientID: self.environment.mobileKey,
                               clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: req.environment.domain + req.endpoint), json(JSON))
        
        waitUntil { done in
            
            self.loginResource.loginUser(username: self.goodUsername, password: self.goodPassword, callback: { loginResponse, errorResponse in
                
                //then
                expect(loginResponse).toNot(beNil())
                expect(loginResponse?.token).to(equal(self.goodToken))
                expect(errorResponse).to(beNil())
                done()
                
            })
        }
        
    }
    
    func testLoginBadHttpResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let req = LoginRequest(environment: self.environment,
                               username: goodUsername,
                               password: goodPassword,
                               clientID: self.environment.mobileKey,
                               clientSecret: self.environment.appID)
        
        //when
        stub(http(.post, uri: req.environment.domain + req.endpoint), json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.loginResource.loginUser(username: self.goodUsername, password: self.goodPassword, callback: { loginResponse, errorResponse in
                
                //then
                expect(loginResponse).to(beNil())
            
                //todo here finish this
                done()
                
            })
        }
        
    }
    
}

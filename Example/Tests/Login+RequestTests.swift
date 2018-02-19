//
//  Login+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class Login_RequestTests: XCTestCase {
    
    // class or data to test
    private var request: LoginRequest!
    
    private var env: KWSNetworkEnvironment!
    private var username: String!
    private var password: String!
    private var clientID: String!
    private var clientSecret: String!
    private var method: NetworkMethod!
    private var endpoint: String!
    
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        
        username = "mock_username"
        password = "mock_password"
        clientID = "mock_client_id"
        clientSecret = "mock_client_secret"
        method = .POST
        endpoint = "oauth/token"
        
        //when
        request = LoginRequest.init(environment: env,
                                    username: username,
                                    password:password,
                                    clientID:clientID,
                                    clientSecret:clientSecret)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        request = nil
        env = nil
    }
    
    
    func testConstantsToBeNotNil(){
        //then
        expect(self.username).toNot(beNil())
        expect(self.password).toNot(beNil())
        expect(self.clientID).toNot(beNil())
        expect(self.clientSecret).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
        
    }
    
    func testRequestToBeNotNil(){
        //then
        expect(self.request).toNot(beNil())
    }
    
    func testRequestEnvironmentToBeNotNil(){
        //then
        expect(self.request.environment).toNot(beNil())
    }
    
    func testRequestMethod(){
        //then
        expect(self.method).to(equal(self.request.method))
    }
    
    func testEndpoint(){
        //then
        expect(self.endpoint).to(equal(self.request.endpoint))
    }
    
    func testRequestBody(){
        let requestBody = self.request.body
        
        //then
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(5))
       
        expect(requestBody?.keys.contains("grant_type")).to(beTrue())
        expect(requestBody?.keys.contains("username")).to(beTrue())
        expect(requestBody?.keys.contains("password")).to(beTrue())
        expect(requestBody?.keys.contains("client_id")).to(beTrue())
        expect(requestBody?.keys.contains("client_secret")).to(beTrue())
        
        expect("password").to(equal((requestBody?["grant_type"] as! String)))
        expect(self.username).to(equal((requestBody?["username"] as! String)))
        expect(self.password).to(equal((requestBody?["password"] as! String)))
        expect(self.clientID).to(equal((requestBody?["client_id"] as! String)))
        expect(self.clientSecret).to(equal((requestBody?["client_secret"] as! String)))
    }
    
    public func testRequestHeader() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(1))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/x-www-form-urlencoded").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beFalse())
    }
    
    func testRequestQueryToBeNil () {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func testRequestFormUrlEncodeToBeTrue(){
        //then
        expect(self.request.formEncodeUrls).to(beTrue())
    }
    
    
    
    
    
}
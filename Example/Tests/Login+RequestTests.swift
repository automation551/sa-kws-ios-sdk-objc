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

class LoginRequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: LoginRequest!
    private var method: NetworkMethod!
    private var endpoint: String!    
    private var username: String!
    private var password: String!
    private var clientID: String!
    private var clientSecret: String!
    
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
        super.tearDown()
    }
    
    func test_Request_ToBe_NotNil(){
        //then
        expect(self.request).toNot(beNil())
    }
    
    func test_Request_Environment_ToBe_NotNil(){
        //then
        expect(self.request.environment).toNot(beNil())
    }
    
    func test_Request_Method(){
        //then
        expect(self.method).to(equal(self.request.method))
    }
    
    func test_Endpoint(){
        //then
        expect(self.endpoint).to(equal(self.request.endpoint))
    }  
    
    func test_Constants_ToBe_NotNil(){
        //then
        expect(self.username).toNot(beNil())
        expect(self.password).toNot(beNil())
        expect(self.clientID).toNot(beNil())
        expect(self.clientSecret).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
        
    }
    
    func test_Request_Body(){
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
    
    public func test_Request_Header() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(1))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/x-www-form-urlencoded").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beFalse())
    }
    
    func test_RequestQuery_ToBe_Nil () {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func test_Request_Form_Url_Encode_ToBe_True(){
        //then
        expect(self.request.formEncodeUrls).to(beTrue())
    }
}

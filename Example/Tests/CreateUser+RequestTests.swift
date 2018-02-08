//
//  CreateUser+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class CreateUser_RequestTests: XCTestCase {
    
    //class or data to test
    private var request: CreateUserRequest!
    private var env: KWSNetworkEnvironment!
    
    private var username: String!
    private var password: String!
    private var dateOfBirth: String!
    private var country: String!
    private var parentEmail: String!
    private var token: String!
    private var appID: Int = 0
    private var method: NetworkMethod!
    private var endpoint: String!
    
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        
        username = "mock_username"
        password = "mock_password"
        dateOfBirth = "mock_dob"
        country = "mock_country"
        parentEmail = "mock_@_email"
        token = "mock_token"
        appID = 1
        method = .POST
        endpoint = "v1/apps/\(appID)/users"
        
        //when
        request = CreateUserRequest(environment: env,
                                    username: username,
                                    password: password,
                                    dateOfBirth: dateOfBirth,
                                    country:country,
                                    parentEmail: parentEmail,
                                    token: token,
                                    appID: appID)
        
        
        
    }
    
    
    override func tearDown() {
        super.tearDown()
        request = nil
        env = nil
    }
    
    func testConstantsToBeNotNil(){
        //then
        expect(self.username).toNot(beNil())
        expect(self.password).toNot(beNil())
        expect(self.dateOfBirth).toNot(beNil())
        expect(self.country).toNot(beNil())
        expect(self.parentEmail).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.appID).toNot(beNil())
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
        expect(requestBody?.count).to(equal(6))
        
        expect(requestBody?.keys.contains("username")).to(beTrue())
        expect(requestBody?.keys.contains("password")).to(beTrue())
        expect(requestBody?.keys.contains("dateOfBirth")).to(beTrue())
        expect(requestBody?.keys.contains("country")).to(beTrue())
        expect(requestBody?.keys.contains("parentEmail")).to(beTrue())
        expect(requestBody?.keys.contains("authenticate")).to(beTrue())
        
        expect(self.username).to(equal((requestBody?["username"] as! String)))
        expect(self.password).to(equal((requestBody?["password"] as! String)))
        expect(self.dateOfBirth).to(equal((requestBody?["dateOfBirth"] as! String)))
        expect(self.country).to(equal((requestBody?["country"] as! String)))
        expect(self.parentEmail).to(equal((requestBody?["parentEmail"] as! String)))
        expect(true).to(equal((requestBody?["authenticate"] as! Bool)))
    }
    
    public func testRequestHeader() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(1))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorizarion")).to(beFalse())
    }
    
    
    func testRequestQuery() {
        let requestQuery = self.request.query
        
        //then
        expect(requestQuery).toNot(beNil())
        expect(requestQuery?.count).to(equal(1))
        
        expect(requestQuery?.keys.contains("access_token")).to(beTrue())
        
        expect(self.token).to(equal((requestQuery?["access_token"] as! String)))
    }
    
    func testRequestFormUrlEncodeToBeFalse(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
    
    
    
}

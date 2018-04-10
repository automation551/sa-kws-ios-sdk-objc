//
//  InviteUser+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class InviteUser_RequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: InviteUserRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var emailAddress: String!
    private var userId: Int = 0
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        emailAddress = "john.doe@email.com"
        userId = 123
        token = "mock_token"
        method = .POST
        endpoint = "v1/users/\(userId)/invite-user"
        
        //when
        request = InviteUserRequest(environment: env,
                                    emailAddress: emailAddress,
                                    userId: userId,
                                    token: token)
    }
    
    override func tearDown() {
        super.tearDown()
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
    
    func testConstantsToBeNotNil(){
        //then
        expect(self.emailAddress).toNot(beNil())
        expect(self.userId).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func testRequestBody(){
        let requestBody = self.request.body
        
        //then
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(1))
        
        expect(requestBody?.keys.contains("email")).to(beTrue())
        
        expect(self.emailAddress).to(equal((requestBody?["email"] as! String)))
    }
    
    public func testRequestHeader() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(2))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beTrue())
    }
    
    func testRequestQuery() {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func testRequestFormUrlEncodeToBeFalse(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}

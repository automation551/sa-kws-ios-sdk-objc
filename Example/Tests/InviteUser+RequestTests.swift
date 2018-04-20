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

class InviteUserRequestTests: XCTestCase {
    
    private var env: ComplianceNetworkEnvironment!
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
        expect(self.emailAddress).toNot(beNil())
        expect(self.userId).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func test_Request_Body(){
        let requestBody = self.request.body
        
        //then
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(1))
        
        expect(requestBody?.keys.contains("email")).to(beTrue())
        
        expect(self.emailAddress).to(equal((requestBody?["email"] as! String)))
    }
    
    public func test_Request_Header() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(2))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beTrue())
    }
    
    func test_Request_Query() {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func test_Request_Form_Url_Encode_ToBe_False(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}

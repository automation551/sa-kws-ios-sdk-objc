//
//  RandomUsername+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//


import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class RandomUsernameRequestTests: XCTestCase {
    
    private var env: ComplianceNetworkEnvironment!
    private var request: RandomUsernameRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var appID: Int = 0
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        appID = 1
        method = .GET
        endpoint = "v2/apps/\(appID)/random-display-name"
        
        //when
        request = RandomUsernameRequest(environment: env,
                                         appID:appID)
        
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
        expect(self.appID).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func test_Request_Body_ToBe_Nil(){
        //then
        expect(self.request.body).to(beNil())
    }
    
    public func test_RequestHeader() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(1))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beFalse())
    }
    
    func test_Request_Query_ToBe_Nil() {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func test_Request_FormUrl_Encode_ToBe_False(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}



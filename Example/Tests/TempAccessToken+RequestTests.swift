//
//  TempAccessToken+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class TempAccessToken_RequestTests: XCTestCase {
    
    
    //class or data to test
    private var request: TempAccessTokenRequest!
    private var env: KWSNetworkEnvironment!
    
    
    private var clientID: String!
    private var clientSecret: String!
    
    private var method: NetworkMethod!
    private var endpoint: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        
        clientID = "mock_client_id"
        clientSecret = "mock_client_secret"
        
        method = .POST
        endpoint = "oauth/token"
        
        //when
        request = TempAccessTokenRequest(environment: env,
                                         clientID:clientID,
                                         clientSecret:clientSecret)
        
    }
    
    
    override func tearDown() {
        super.tearDown()
        request = nil
        env = nil
    }
    
    func testConstantsToBeNotNil(){
        //then
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
        expect(requestBody?.count).to(equal(3))
        
        expect(requestBody?.keys.contains("grant_type")).to(beTrue())
        expect(requestBody?.keys.contains("client_id")).to(beTrue())
        expect(requestBody?.keys.contains("client_secret")).to(beTrue())
        
        expect("client_credentials").to(equal((requestBody?["grant_type"] as! String)))
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
        
        expect(requestHeaders?.keys.contains("Authorizarion")).to(beFalse())
    }
    
    
    func testRequestQueryToBeNil() {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func testRequestFormUrlEncodeToBeTrue(){
        //then
        expect(self.request.formEncodeUrls).to(beTrue())
    }
    
}

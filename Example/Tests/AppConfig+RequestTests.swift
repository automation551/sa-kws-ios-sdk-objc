//
//  AppConfig+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class AppConfig_RequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: AppConfigRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var clientID: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        clientID = "mock_client_id"        
        method = .GET
        endpoint = "v1/apps/config"
        
        //when
        request = AppConfigRequest(environment: env,
                                         clientID:clientID)
        
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
        expect(self.clientID).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }

    func testRequestBody(){
        //then
        expect(self.request.body).to(beNil())
    }
    
    public func testRequestHeader() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(1))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beFalse())
    }
    
    
    func testRequestQuery() {
        
        let requestQuery = self.request.query
        
        //then
        expect(requestQuery).toNot(beNil())
        expect(requestQuery?.count).to(equal(1))
        
        expect(requestQuery?.keys.contains("oauthClientId")).to(beTrue())
        
        expect(self.clientID).to(equal((requestQuery?["oauthClientId"] as! String)))
    }
    
    func testRequestFormUrlEncodeToBeFalse(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
    
}


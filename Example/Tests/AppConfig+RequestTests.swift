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

class AppConfigRequestTests: XCTestCase {
    
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
    
    func test_Request_ToBe_NotNil(){
        //then
        expect(self.request).toNot(beNil())
    }
    
    func test_RequestEnvironment_ToBe_NotNil(){
        //then
        expect(self.request.environment).toNot(beNil())
    }
    
    func test_RequestMethod(){
        //then
        expect(self.method).to(equal(self.request.method))
    }
    
    func test_Endpoint(){
        //then
        expect(self.endpoint).to(equal(self.request.endpoint))
    }  
    
    func test_Constants_ToBe_NotNil(){
        //then
        expect(self.clientID).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }

    func test_RequestBody_ToBe_Nil(){
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
    
    
    func test_RequestQuery() {
        
        let requestQuery = self.request.query
        
        //then
        expect(requestQuery).toNot(beNil())
        expect(requestQuery?.count).to(equal(1))
        
        expect(requestQuery?.keys.contains("oauthClientId")).to(beTrue())
        
        expect(self.clientID).to(equal((requestQuery?["oauthClientId"] as! String)))
    }
    
    func test_RequestFormUrlEncodeToBeFalse(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }    
}


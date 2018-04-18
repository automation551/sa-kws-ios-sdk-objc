//
//  HasTriggeredEvent+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class HasTriggeredEventRequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: HasTriggeredEventRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var eventId: Int = 0
    private var userId: Int = 0
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        eventId = 802
        userId = 123
        token = "mock_token"
        method = .POST
        endpoint = "v1/users/\(userId)/has-triggered-event"
        
        //when
        request = HasTriggeredEventRequest(environment: env,
                                           eventId: eventId,
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
        expect(self.eventId).toNot(beNil())
        expect(self.userId).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func test_RequestBody(){
        let requestBody = self.request.body
        
        //then
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(1))
        
        expect(requestBody?.keys.contains("eventId")).to(beTrue())
        
        expect(self.eventId).to(equal((requestBody?["eventId"] as! Int)))
    }
    
    public func test_RequestHeader() {
        let requestHeaders = self.request.headers
        
        //then
        expect(requestHeaders).toNot(beNil())
        expect(requestHeaders?.count).to(equal(2))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beTrue())
    }
    
    func test_RequestQuery() {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func test_RequestFormUrlEncode_ToBe_False(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}

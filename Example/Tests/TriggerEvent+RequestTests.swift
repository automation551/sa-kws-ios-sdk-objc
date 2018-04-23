//
//  TriggerEvent+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class TriggerEventRequestTests: XCTestCase {
    
    private var env: ComplianceNetworkEnvironment!
    private var request: TriggerEventRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var points: Int = 0
    private var eventId: String!
    private var userId: Int = 0
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        points = 20
        eventId = "8X9QneMSaxU2VzCBJI5YdxRGG7l3GOUw"
        userId = 123
        token = "mock_token"
        method = .POST
        endpoint = "v1/users/\(userId)/trigger-event"
        
        //when
        request = TriggerEventRequest(environment: env,
                                      eventId: eventId,
                                      points: points,
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
        expect(self.eventId).toNot(beNil())
        expect(self.userId).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func test_Request_Body(){
        let requestBody = self.request.body
        
        //then
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(2))
        
        expect(requestBody?.keys.contains("points")).to(beTrue())
        expect(requestBody?.keys.contains("token")).to(beTrue())
        
        expect(self.points).to(equal((requestBody?["points"] as! Int)))
        expect(self.eventId).to(equal((requestBody?["token"] as! String)))
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

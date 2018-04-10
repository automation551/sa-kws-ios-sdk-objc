//
//  GetUserScore+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 10/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class GetUserScore_RequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: GetUserScoreRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var appId: Int = 0
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        appId = 2
        token = "mock_token"
        method = .GET
        endpoint = "v1/apps/\(appId)/score"
        
        //when
        request = GetUserScoreRequest.init(environment: env,
                                           appId: appId,
                                           token:token)        
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
        expect(self.appId).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func testRequestBodyToBeNil(){
        //then
        expect(self.request.body).to(beNil())        
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
    
    func testRequestQueryToBeNil() {
        //then
        expect(self.request.query).to(beNil())
        
    }
    
    func testRequestFormUrlEncodeToBeFalse(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}

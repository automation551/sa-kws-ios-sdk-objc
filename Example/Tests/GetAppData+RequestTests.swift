//
//  GetAppData+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class GetAppDataRequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: GetAppDataRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var userId: Int = 123
    private var appId: Int = 2
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        token = "mock_token"
        method = .GET
        endpoint = "v1/apps/\(appId)/users/\(userId)/app-data"
        
        //when
        request = GetAppDataRequest.init(environment: env,
                                         appId: appId,
                                         userId: userId,
                                         token:token)
        
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
        expect(self.userId).toNot(beNil())
        expect(self.appId).toNot(beNil())
        expect(self.token).toNot(beNil())
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
        expect(requestHeaders?.count).to(equal(2))
        
        expect(requestHeaders?.keys.contains("Content-Type")).to(beTrue())
        expect("application/json").to(equal(requestHeaders?["Content-Type"]))
        
        expect(requestHeaders?.keys.contains("Authorization")).to(beTrue())
    }
    
    func test_RequestQuery_ToBe_Nil() {
        //then
        expect(self.request.query).to(beNil())
    }
    
    func test_RequestFormUrlEncode_ToBe_False(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}

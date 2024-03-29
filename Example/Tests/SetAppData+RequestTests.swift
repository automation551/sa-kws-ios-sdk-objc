//
//  SetAppData+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class SetAppDataRequestTests: XCTestCase {
    
    public var env: ComplianceNetworkEnvironment!
    public var request: SetAppDataRequest!
    public var method: NetworkMethod!
    public var endpoint: String!
    private var appId: Int = 0
    private var userId: Int = 0
    private var value: Int = 0
    private var key: String!
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        appId = 1
        userId = 123
        value = 24
        key = "new_value"
        token = "mock_token"
        method = .POST
        endpoint = "v1/apps/\(appId)/users/\(userId)/app-data/set"
        
        //when
        request = SetAppDataRequest(environment: env,
                                    appId: appId,
                                    userId: userId,
                                    value: value,
                                    key: key,
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
        expect(self.appId).toNot(beNil())
        expect(self.userId).toNot(beNil())
        expect(self.value).toNot(beNil())
        expect(self.key).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func test_Request_Body(){
        let requestBody = self.request.body
        
        //then
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(2))
        
        expect(requestBody?.keys.contains("name")).to(beTrue())
        expect(requestBody?.keys.contains("value")).to(beTrue())
        
        expect(self.key).to(equal((requestBody?["name"] as! String)))
        expect(self.value).to(equal((requestBody?["value"] as! Int)))
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


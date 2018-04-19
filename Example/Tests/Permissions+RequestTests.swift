//
//  Permissions+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 19/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class PermissionsRequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: PermissionsRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var userId: Int = 0
    private var token: String!
    private var permissionsList: [String]!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        userId = 1
        token = "mock_token"
        permissionsList = ["good_permission_1"]
        method = .POST
        endpoint = "v1/users/\(userId)/request-permissions"
        
        //when
        request = PermissionsRequest(environment: env,
                                     userId: userId,
                                     token: token,
                                     permissionsList: permissionsList)
        
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
        expect(self.userId).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.permissionsList).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func test_Request_Body_ToBe_NotNil(){
        //then
        
        let requestBody = self.request.body
        
        expect(requestBody).toNot(beNil())
        expect(requestBody?.count).to(equal(1))
          expect(requestBody?.keys.contains("permissions")).to(beTrue())
        expect(self.permissionsList).to(equal((requestBody?["permissions"] as! [String])))
        
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
    
    func test_Request_Query_ToBe_Nil() {
        //then
        expect(self.request.query).to(beNil())
        
    }
    
    func test_Request_Form_Url_Encode_ToBe_False(){
        //then
        expect(self.request.formEncodeUrls).to(beFalse())
    }
}

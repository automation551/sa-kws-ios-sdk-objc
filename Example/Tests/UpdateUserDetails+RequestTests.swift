//
//  UpdateUserDetails+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 14/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class UpdateUserDetails_RequestTests: XCTestCase {
    
    private var env: KWSNetworkEnvironment!
    private var request: UpdateUserDetailsRequest!
    private var method: NetworkMethod!
    private var endpoint: String!
    private var userId: Int = 123
    private var token: String!
    private var goodUsername = "good_username"
    private var mapUserDetails : [String : Any]!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        token = "mock_token"
        method = .PUT
        endpoint = "v1/users/\(userId)"
        
        //when        
        mapUserDetails = ["firstName" : "John",
                          "lastName" : "Doe",
                          "address" : [ "street" : "Street One",
                                        "city" : "London",
                                        "postCode" : "EA12 34Z",
                                        "country" : "United Kingdom",
                                        "countryCode" : "UK",
                                        "countryName" : "United Kingdom"] ]
        
        request = UpdateUserDetailsRequest.init(environment: env,
                                                userDetailsMap: mapUserDetails,
                                                userId: userId,
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
        expect(self.userId).toNot(beNil())
        expect(self.token).toNot(beNil())
        expect(self.mapUserDetails).toNot(beNil())
        expect(self.endpoint).toNot(beNil())
        expect(self.method).toNot(beNil())
    }
    
    func testRequestBodyToNotBeNil(){
        //then
        expect(self.request.body).toNot(beNil())
        
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

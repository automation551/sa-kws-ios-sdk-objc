//
//  RandomUsername+RequestTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//


import XCTest
import Nimble
import SAMobileBase
import KWSiOSSDKObjC

class RandomUsername_RequestTests: XCTestCase {
    
    
    //class or data to test
    private var request: RandomUsernameRequest!
    private var env: KWSNetworkEnvironment!
    
    private var appID: Int = 0
    
    private var method: NetworkMethod!
    private var endpoint: String!
    
    override func setUp() {
        super.setUp()
        
        // given
        env = GoodMockNetworkEnvironment()
        appID = 1
        method = .GET
        endpoint = "v2/apps/\(appID)/random-display-name"
        
        //when
        request = RandomUsernameRequest(environment: env,
                                         appID:appID)
        
    }
    
    
    override func tearDown() {
        super.tearDown()
        request = nil
        env = nil
    }
    
    func testConstantsToBeNotNil(){
        //then
        expect(self.appID).toNot(beNil())
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
    
    func testRequestBodyToBeNil(){
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
        
        expect(requestHeaders?.keys.contains("Authorizarion")).to(beFalse())
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



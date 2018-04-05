//
//  CreateUser_CreateUser+ObjectProvider.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class CreateUser_CreateUser_ObjectProvider: XCTestCase {
    
    // class or data to test
    private var service: AuthServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.service = KWSSDK.getService(value: AuthServiceProtocol.self, environment: self.environment)
        
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    func test(){
        
        let JSON: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        
        let request = TempAccessTokenRequest(environment: self.environment,
                                             clientID: self.environment.mobileKey,
                                             clientSecret: self.environment.appID)
        
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri), json(JSON!))
        
        waitUntil { done in
            
            self.service.createUser(username: "test_user",
                                    password: "testtest",
                                    timeZone: nil,
                                    dateOfBirth: "2012-03-03",
                                    country: "US",
                                    parentEmail: "parent.email@email.com") { tempAccessTokenResponse, error in
                                        
                                        expect(tempAccessTokenResponse).toNot(beNil())
                                        expect(tempAccessTokenResponse?.token).to(equal("good_token"))
                                        expect(error).to(beNil())
                                        
                                        
                                        done()
            }            
        }
    }
}

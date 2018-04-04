//
//  CreateUser_TempAccessToken+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class CreateUser_TempAccessToken_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //Temp access token mapping
    func test_TempAccessToken_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"temp_access_token_success_response")
        
        let authResponse = try? LoginAuthResponse.decode(JSON!)
        
        expect(authResponse).toNot(beNil())
        expect(authResponse?.token).to(equal("good_token"))
    }
}

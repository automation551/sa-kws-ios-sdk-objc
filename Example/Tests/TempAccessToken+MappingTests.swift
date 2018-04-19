//
//  TempAccessToken+MappingTests.swift
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

class TempAccessTokenMappingTests: XCTestCase {
    
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
        
        let authResponse = try? LoginAuthResponseModel.decode(JSON!)
        
        expect(authResponse).toNot(beNil())
        expect(authResponse?.token).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcHBJZCI6MiwiY2xpZW50SWQiOiJ0ZXN0LWFwcCIsInNjb3BlIjoibW9iaWxlQXBwIiwiaWF0IjoxNTIzMjAyOTU2LCJleHAiOjE1MjMyODkzNTYsImlzcyI6InN1cGVyYXdlc29tZSJ9.ss2qbLJJkqJ1LHgl06ivtthZ5g9PhYIVYJJqW4NIuFE"))
    }
}

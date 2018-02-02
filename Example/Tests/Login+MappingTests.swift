//
//  Login+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 30/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class Login_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLoginResponseMapping() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"login_success_response")
        
        let loginResponse = try? AuthResponse.decode(JSON!)
        
        expect(loginResponse).toNot(beNil())
        expect(loginResponse?.token).to(equal("good_token"))
        
    }
    
    func testLoginResponseMappingEmptyResponse() {
        
        let JSON = [
            "access_token": NSNull()
            ] as [String : Any]
        
        let loginResponse = try? AuthResponse.decode(JSON)
        
        expect(loginResponse).toNot(beNil())
    }
   
    
}

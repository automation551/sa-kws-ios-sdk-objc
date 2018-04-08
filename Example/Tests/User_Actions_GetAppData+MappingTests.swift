//
//  User_Actions_GetAppData+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//


import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class User_Actions_GetAppData_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_User_Actions_GetAppData_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"get_app_data_success_response")
        
        let appDataResponse = try? AppDataWrapper.decode(JSON!)
        
        expect(appDataResponse).toNot(beNil())
        expect(appDataResponse?.results.count).to(equal(4))
        expect(appDataResponse?.count).to(equal(4))
        expect(appDataResponse?.offset).to(equal(0))
        expect(appDataResponse?.limit).to(equal(1000))
    }
    
    func test_User_Actions_GetAppData_Mapping_BadToken_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let errorResponse = try? ErrorWrapper.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        //todo
        
    }
    
}

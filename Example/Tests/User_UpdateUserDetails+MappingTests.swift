//
//  User_UpdateUserDetails+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 14/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class User_UpdateUserDetails_MappingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_User_UpdateUserDetails_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_detail_success_response")
        
        let userDetailsResponse = try? UpdateUserDetailsFakeResponse.decode(JSON!)
        
        expect(userDetailsResponse).toNot(beNil())
        expect(userDetailsResponse?.userUpdated).to(beTrue())
        
    }

    
    func test_User_UpdateUserDetails_Mapping_Forbidden_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_detail_permission_not_granted_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.errorMessage).to(equal("permission not granted"))
        
    }

    func test_User_UpdateUserDetails_Mapping_Address_Fails_Complete_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_details_address_fails_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"address\" fails because [child \"street\" fails because [\"street\" is required], child \"postCode\" fails because [\"postCode\" is required], child \"city\" fails because [\"city\" is required], child \"country\" fails because [\"country\" is required]]"))
        
        expect(errorResponse?.invalid?.addressStreet).toNot(beNil())
        expect(errorResponse?.invalid?.addressStreet?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressStreet?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressStreet?.errorMessage).to(equal("\"street\" is required"))
        
        expect(errorResponse?.invalid?.addressPostCode).toNot(beNil())
        expect(errorResponse?.invalid?.addressPostCode?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressPostCode?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressPostCode?.errorMessage).to(equal("\"postCode\" is required"))
        
        expect(errorResponse?.invalid?.addressCity).toNot(beNil())
        expect(errorResponse?.invalid?.addressCity?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressCity?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressCity?.errorMessage).to(equal("\"city\" is required"))
        
        expect(errorResponse?.invalid?.addressCountry).toNot(beNil())
        expect(errorResponse?.invalid?.addressCountry?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressCountry?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressCountry?.errorMessage).to(equal("\"country\" is required"))
        
    }
    
}

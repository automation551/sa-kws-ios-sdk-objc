//
//  UpdateUserDetails+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 14/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class UpdateUserDetailsMappingTests: XCTestCase {

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
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let userDetailsResponse = try? JSONDecoder().decode(UpdateUserDetailsFakeResponseModel.self, from: jsonData!)
        
        expect(userDetailsResponse).toNot(beNil())
        expect(userDetailsResponse?.userUpdated).to(beTrue())        
    }
    
    func test_User_UpdateUserDetails_Mapping_Forbidden_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_detail_permission_not_granted_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)

        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("permission not granted"))
    }

    func test_User_UpdateUserDetails_Mapping_Address_Fails_Complete_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_details_address_fails_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"address\" fails because [child \"street\" fails because [\"street\" is required], child \"postCode\" fails because [\"postCode\" is required], child \"city\" fails because [\"city\" is required], child \"country\" fails because [\"country\" is required]]"))
        
        expect(errorResponse?.invalid?.addressStreet).toNot(beNil())
        expect(errorResponse?.invalid?.addressStreet?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressStreet?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressStreet?.message).to(equal("\"street\" is required"))
        
        expect(errorResponse?.invalid?.addressPostCode).toNot(beNil())
        expect(errorResponse?.invalid?.addressPostCode?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressPostCode?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressPostCode?.message).to(equal("\"postCode\" is required"))
        
        expect(errorResponse?.invalid?.addressCity).toNot(beNil())
        expect(errorResponse?.invalid?.addressCity?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressCity?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressCity?.message).to(equal("\"city\" is required"))
        
        expect(errorResponse?.invalid?.addressCountry).toNot(beNil())
        expect(errorResponse?.invalid?.addressCountry?.code).to(equal(6))
        expect(errorResponse?.invalid?.addressCountry?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.addressCountry?.message).to(equal("\"country\" is required"))
    }
    
    func test_User_UpdateParentEmail_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_parent_email_success_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let userParentEmailResponse = try? JSONDecoder().decode(UpdateUserDetailsFakeResponseModel.self, from: jsonData!)
        
        expect(userParentEmailResponse).toNot(beNil())
        expect(userParentEmailResponse?.emailUpdated).to(beTrue())
    }
    
    func test_User_UpdateParentEmail_Mapping_Email_Already_Set_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_parent_email_already_set_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(10))
        expect(errorResponse?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.message).to(equal("parentEmail already set"))
        expect(errorResponse?.invalid?.parentEmail).toNot(beNil())
        expect(errorResponse?.invalid?.parentEmail?.code).to(equal(10))
        expect(errorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.invalid?.parentEmail?.message).to(equal("parentEmail already set"))
    }
    
    func test_User_UpdateParentEmail_Mapping_Invalid_Email_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_parent_email_invalid_email_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
        expect(errorResponse?.invalid?.parentEmail).toNot(beNil())
        expect(errorResponse?.invalid?.parentEmail?.code).to(equal(7))
        expect(errorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.parentEmail?.message).to(equal("\"parentEmail\" must be a valid email"))
    }
}

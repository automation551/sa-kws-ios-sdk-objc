//
//  User_UpdateParentEmail+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 19/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class User_UpdateUser_ParentEmail_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_User_UpdateParentEmail_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_parent_email_success_response")
        
        let userParentEmailResponse = try? UpdateUserDetailsFakeResponse.decode(JSON!)
        
        expect(userParentEmailResponse).toNot(beNil())
        expect(userParentEmailResponse?.emailUpdated).to(beTrue())
        
    }
    
    func test_User_UpdateParentEmail_Mapping_Email_Already_Set_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_parent_email_already_set_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(10))
        expect(errorResponse?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.errorMessage).to(equal("parentEmail already set"))
        expect(errorResponse?.invalid?.parentEmail).toNot(beNil())
        expect(errorResponse?.invalid?.parentEmail?.code).to(equal(10))
        expect(errorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.invalid?.parentEmail?.errorMessage).to(equal("parentEmail already set"))
        
    }

    func test_User_UpdateParentEmail_Mapping_Invalid_Email_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"update_user_parent_email_invalid_email_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
        expect(errorResponse?.invalid?.parentEmail).toNot(beNil())
        expect(errorResponse?.invalid?.parentEmail?.code).to(equal(7))
        expect(errorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.parentEmail?.errorMessage).to(equal("\"parentEmail\" must be a valid email"))
        
    }
    
}

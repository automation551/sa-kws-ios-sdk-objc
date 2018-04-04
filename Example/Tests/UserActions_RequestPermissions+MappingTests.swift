//
//  User_RequestPermissions+MappingTests.swift
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

class UserActions_RequestPermissions_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_User_Permissions_Request_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"permission_request_success_response")
        
        let userParentEmailResponse = try? UpdateUserDetailsFakeResponse.decode(JSON!)
        
        expect(userParentEmailResponse).toNot(beNil())
        expect(userParentEmailResponse?.permissionsRequested).to(beTrue())
    }
    
    func test_User_Permissions_Request_Mapping_Permission_Required_Response() {
        //400
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"permission_request_permission_required_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"permissions\" fails because [\"permissions\" is required]"))
        expect(errorResponse?.invalid?.permissions).toNot(beNil())
        expect(errorResponse?.invalid?.permissions?.code).to(equal(6))
        expect(errorResponse?.invalid?.permissions?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.permissions?.errorMessage).to(equal("\"permissions\" is required"))
        
    }
    
    func test_User_Permissions_Request_Mapping_Not_Supported_For_User_Response() {
        //403
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"permission_request_not_supported_for_user_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.errorMessage).to(equal("operation not supported for this user"))
    }
    
    func test_User_Permissions_Request_Mapping_Permission_Not_Found_Response() {
        //404
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"permission_request_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(2))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        expect(errorResponse?.errorMessage).to(equal("permissions not found: mock_permission"))
    }
}

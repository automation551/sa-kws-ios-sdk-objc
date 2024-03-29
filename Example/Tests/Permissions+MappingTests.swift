//
//  Permissions+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 19/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class PermissionsMappingTests: XCTestCase {
    
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
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let userParentEmailResponse = try? JSONDecoder().decode(UpdateUserDetailsFakeResponseModel.self, from: jsonData!)
        
        expect(userParentEmailResponse).toNot(beNil())
        expect(userParentEmailResponse?.permissionsRequested).to(beTrue())
    }
    
    func test_User_Permissions_Request_Mapping_Permission_Required_Response() {
        //400
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"permission_request_permission_required_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"permissions\" fails because [\"permissions\" is required]"))
        expect(errorResponse?.invalid?.permissions).toNot(beNil())
        expect(errorResponse?.invalid?.permissions?.code).to(equal(6))
        expect(errorResponse?.invalid?.permissions?.codeMeaning).to(equal("missing"))
        expect(errorResponse?.invalid?.permissions?.message).to(equal("\"permissions\" is required"))
    }
    
    func test_User_Permissions_Request_Mapping_Not_Supported_For_User_Response() {
        //403
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_operation_not_supported_for_user_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(1))
        expect(errorResponse?.codeMeaning).to(equal("forbidden"))
        expect(errorResponse?.message).to(equal("operation not supported for this user"))
    }
    
    func test_User_Permissions_Request_Mapping_Permission_Not_Found_Response() {
        //404
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"permission_request_not_found_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(2))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        expect(errorResponse?.message).to(equal("permissions not found: mock_permission"))
    }
}

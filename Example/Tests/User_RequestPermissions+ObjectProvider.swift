//
//  User_RequestPermissions+ObjectProvider.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 19/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class User_RequestPermissions_ObjectProviderTests: XCTestCase {
    
    
    //class or data to test
    private var userService: UserService!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var goodPermissions: [String] = ["mock_permission"]
    private var badPermissions: [String] = [""]
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.userService = KWSSDK.getService(value: UserService.self, environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        userService = nil
        environment = nil
    }
    
    func test_User_Permissions_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_success_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                               userId: goodUserId,
                                               token: goodToken,
                                               permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 204))
        
        waitUntil { done in
            
            self.userService.requestPermissions(userId: self.goodUserId,
                                               token: self.goodToken,
                                               permissionsList: self.goodPermissions,
                                               callback: {  permissionsResponse, error in
                                                
                                                expect(permissionsResponse).to(beTrue())
                                                expect(error).to(beNil())
                                                
                                                done()
                                                
            })
        }
    }
    
    func test_User_Permissions_Required_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_permission_required_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken,
                                         permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userService.requestPermissions(userId: self.goodUserId,
                                                token: self.goodToken,
                                                permissionsList: self.goodPermissions,
                                                callback: {  permissionsResponse, error in
                                                    
                                                    expect(permissionsResponse).to(beFalse())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(5))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("child \"permissions\" fails because [\"permissions\" is required]"))
                                                    expect((error as! ErrorResponse).invalid?.permissions).toNot(beNil())
                                                    expect((error as! ErrorResponse).invalid?.permissions?.code).to(equal(6))
                                                    expect((error as! ErrorResponse).invalid?.permissions?.codeMeaning).to(equal("missing"))
                                                    expect((error as! ErrorResponse).invalid?.permissions?.errorMessage).to(equal("\"permissions\" is required"))
                                                    
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    func test_User_Permissions_Not_Supported_For_User_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_not_supported_for_user_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: badUserId,
                                         token: goodToken,
                                         permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userService.requestPermissions(userId: self.badUserId,
                                                token: self.goodToken,
                                                permissionsList: self.goodPermissions,
                                                callback: {  permissionsResponse, error in
                                                    
                                                    expect(permissionsResponse).to(beFalse())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(1))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("forbidden"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("operation not supported for this user"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    func test_User_Permissions_Requested_Not_Found_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"permission_request_not_found_response")
        
        let request = PermissionsRequest(environment: self.environment,
                                         userId: badUserId,
                                         token: goodToken,
                                         permissionsList: goodPermissions)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.userService.requestPermissions(userId: self.badUserId,
                                                token: self.goodToken,
                                                permissionsList: self.goodPermissions,
                                                callback: {  permissionsResponse, error in
                                                    
                                                    expect(permissionsResponse).to(beFalse())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(2))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("notFound"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("permissions not found: mock_permission"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
}

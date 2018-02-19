//
//  User_UpdateUserDetails+ObjectProvider.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 14/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class User_UpdateUserDetails_ObjectProviderTests: XCTestCase {
    
    
    //class or data to test
    private var userService: UserService!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var userDetails: UserDetails!
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.userService = KWSSDK.getService(value: UserService.self, environment: self.environment)
        
        self.userDetails = UserDetails()
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        userService = nil
        environment = nil
    }
    
    func test_User_UpdateUserDetails_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_detail_success_response")
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetails: userDetails,
                                               userId: goodUserId,
                                               token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.put, uri: uri ) , json(JSON!, status: 204))
        
        waitUntil { done in
            
            self.userService.updateUserDetails(userId: self.goodUserId,
                                               token: self.goodToken,
                                               userDetails: self.userDetails,
                                               callback: {  userDetailsResponse, error in
                                                
                                                expect(userDetailsResponse).to(beTrue())
                                                expect(error).to(beNil())
                                                
                                                done()
                                                
            })
        }
    }
    
    
    func test_User_UpdateUserDetails_Forbidden_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_detail_permission_not_granted_response")
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetails: userDetails,
                                               userId: goodUserId,
                                               token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.put, uri: uri ) , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userService.updateUserDetails(userId: self.goodUserId,
                                               token: self.goodToken,
                                               userDetails: self.userDetails,
                                               callback: {  userDetailsResponse, error in
                                                
                                                expect(userDetailsResponse).to(beFalse())
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorResponse).code).to(equal(1))
                                                expect((error as! ErrorResponse).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorResponse).errorMessage).to(equal("permission not granted"))
                                                
                                                done()
                                                
            })
        }
    }
    
    func test_User_UpdateUserDetails_Address_Fails_Complete_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_details_address_fails_response")
        
        //given
        userDetails = UserDetails(address: UserAddress())
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetails: userDetails,
                                               userId: goodUserId,
                                               token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.put, uri: uri ) , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userService.updateUserDetails(userId: self.goodUserId,
                                               token: self.goodToken,
                                               userDetails: self.userDetails,
                                               callback: {  userDetailsResponse, error in
                                                
                                                expect(userDetailsResponse).to(beFalse())
                                                
                                                expect(error).toNot(beNil())
                                                
                                                expect((error as! ErrorResponse).code).to(equal(5))
                                                expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                expect((error as! ErrorResponse).errorMessage).to(equal("child \"address\" fails because [child \"street\" fails because [\"street\" is required], child \"postCode\" fails because [\"postCode\" is required], child \"city\" fails because [\"city\" is required], child \"country\" fails because [\"country\" is required]]"))
                                                
                                                expect((error as! ErrorResponse).invalid?.addressStreet).toNot(beNil())
                                                expect((error as! ErrorResponse).invalid?.addressStreet?.code).to(equal(6))
                                                expect((error as! ErrorResponse).invalid?.addressStreet?.codeMeaning).to(equal("missing"))
                                                expect((error as! ErrorResponse).invalid?.addressStreet?.errorMessage).to(equal("\"street\" is required"))
                                                
                                                expect((error as! ErrorResponse).invalid?.addressPostCode).toNot(beNil())
                                                expect((error as! ErrorResponse).invalid?.addressPostCode?.code).to(equal(6))
                                                expect((error as! ErrorResponse).invalid?.addressPostCode?.codeMeaning).to(equal("missing"))
                                                expect((error as! ErrorResponse).invalid?.addressPostCode?.errorMessage).to(equal("\"postCode\" is required"))
                                                
                                                expect((error as! ErrorResponse).invalid?.addressCity).toNot(beNil())
                                                expect((error as! ErrorResponse).invalid?.addressCity?.code).to(equal(6))
                                                expect((error as! ErrorResponse).invalid?.addressCity?.codeMeaning).to(equal("missing"))
                                                expect((error as! ErrorResponse).invalid?.addressCity?.errorMessage).to(equal("\"city\" is required"))
                                                
                                                expect((error as! ErrorResponse).invalid?.addressCountry).toNot(beNil())
                                                expect((error as! ErrorResponse).invalid?.addressCountry?.code).to(equal(6))
                                                expect((error as! ErrorResponse).invalid?.addressCountry?.codeMeaning).to(equal("missing"))
                                                expect((error as! ErrorResponse).invalid?.addressCountry?.errorMessage).to(equal("\"country\" is required"))
                                                done()
                                                
            })
        }
    }
    
    
}

//
//  User_UpdateParentEmail+ObjectProviderTests.swift
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
import SAProtobufs

class User_UpdateUser_ParentEmail_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var userService: UserServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var userDetails: UserDetails!
    
    private var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOjM0NDIsImFwcElkIjozNTgsImNsaWVudElkIjoia3dzLXNkay10ZXN0aW5nIiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTIyODI5Nzk1LCJleHAiOjE4MzgxODk3OTUsImlzcyI6InN1cGVyYXdlc29tZSJ9.AUwbdZYTKEKyUGusGN6DRwpoBZbWHM7m4RqpRFutjDQ6AwUVEEYlQ9upGf6In3p73PcHtS9HjrqJtg6Aox6s9IzcTPK5lPFWm-VrFnECH6XnktslUYzBtOeepgwjhlbugjCSaVgfJ2CPfQZJ6f4rUv7fcsfh74xmmYRXOTzCmQh_LNZcvs5vLK2BHwdppa4mWj0HUgoIcbOwxBR0ZgHg7qFfCEQMlql-cfd6gBJ81-q7zZlcoXHS4MAF2eBs_kh9vHCwM2ajTANdFgsW6MToR_xYDN1h-dfRIGCOmQDqM2UMVQ8IW5pXYRT_S7iNbobccE-Gx7jYmGErCC4aHWL2WQ"
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.userService = KWSSDK.getService(value: UserServiceProtocol.self, environment: self.environment)
    }
    
    override func tearDown() {
        super.tearDown()
        userService = nil
        environment = nil
    }
    
    func test_User_UpdateParentEmail_ValidRequestAndResponse(){
        
        let mapUserDetails : [String : Any] = ["parentEmail" : "parent.email@mail.com"]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_parent_email_success_response")
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetailsMap: mapUserDetails,
                                               userId: goodUserId,
                                               token: token)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.put, uri: uri ) , json(JSON!, status: 204))
        
        waitUntil { done in
            
            self.userService.updateUser(details: mapUserDetails,
                                               token: self.token,
                                               completionHandler: { error in
                                                
                                                expect(error).to(beNil())
                                                done()
            })
        }
    }
    
    func test_User_UpdateParentEmail_Email_Already_Set_Response(){
        
        let mapUserDetails : [String : Any] = ["parentEmail" : "parent.email@mail.com"]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_parent_email_already_set_response")
        
        //when
        stub(everything , json(JSON!, status: 409))
        
        waitUntil { done in
            self.userService.updateUser(details: mapUserDetails,
                                               token: self.token,
                                               completionHandler: { error in
                                                
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorResponse).code).to(equal(10))
                                                expect((error as! ErrorResponse).codeMeaning).to(equal("conflict"))
                                                expect((error as! ErrorResponse).errorMessage).to(equal("parentEmail already set"))
                                                expect((error as! ErrorResponse).invalid?.parentEmail).toNot(beNil())
                                                expect((error as! ErrorResponse).invalid?.parentEmail?.code).to(equal(10))
                                                expect((error as! ErrorResponse).invalid?.parentEmail?.codeMeaning).to(equal("conflict"))
                                                expect((error as! ErrorResponse).invalid?.parentEmail?.errorMessage).to(equal("parentEmail already set"))
                                                
                                                done()
            })
        }
    }
    
    
    func test_User_UpdateParentEmail_Invalid_Email_Response(){
        
        let mapUserDetails : [String : Any] = ["parentEmail" : "parent.email"]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_parent_email_invalid_email_response")
        
        //when
        stub(everything , json(JSON!, status: 400))
        
        waitUntil { done in
            self.userService.updateUser(details: mapUserDetails,
                                               token: self.token,
                                               completionHandler: { error in
                                                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorResponse).code).to(equal(5))
                                                expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                expect((error as! ErrorResponse).errorMessage).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
                                                expect((error as! ErrorResponse).invalid?.parentEmail).toNot(beNil())
                                                expect((error as! ErrorResponse).invalid?.parentEmail?.code).to(equal(7))
                                                expect((error as! ErrorResponse).invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
                                                expect((error as! ErrorResponse).invalid?.parentEmail?.errorMessage).to(equal("\"parentEmail\" must be a valid email"))
                                                
                                                done()
            })
        }
    }
}

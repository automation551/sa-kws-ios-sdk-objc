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
import SAProtobufs

class User_UpdateUser_UserDetails_ObjectProviderTests: XCTestCase {
    
    
    //class or data to test
    private var userService: UserServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
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
    
    func test_User_UpdateUserDetails_ValidRequestAndResponse(){
        
        let mapUserDetails : [String : Any] = ["firstName" : "John",
                                               "lastName" : "Doe",
                                               "address" : [ "street" : "Street One",
                                                             "city" : "London",
                                                             "postCode" : "EA12 34Z",
                                                             "country" : "United Kingdom",
                                                             "countryCode" : "UK",
                                                             "countryName" : "United Kingdom"] ]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_detail_success_response")
        
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
    
    
    func test_User_UpdateUserDetails_Forbidden_Response(){
        
        let mapUserDetails : [String : Any] = ["firstName" : "John",
                                               "lastName" : "Doe",
                                               "address" : [ "street" : "Street One",
                                                             "city" : "London",
                                                             "postCode" : "EA12 34Z",
                                                             "country" : "United Kingdom",
                                                             "countryCode" : "UK",
                                                             "countryName" : "United Kingdom"] ]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_detail_permission_not_granted_response")
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetailsMap: mapUserDetails,
                                               userId: goodUserId,
                                               token: token)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.put, uri: uri ) , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.userService.updateUser(details: mapUserDetails,
                                        token: self.token,
                                        completionHandler: { error in
                                            
                                            expect(error).toNot(beNil())
                                            expect((error as! ErrorResponse).code).to(equal(1))
                                            expect((error as! ErrorResponse).codeMeaning).to(equal("forbidden"))
                                            expect((error as! ErrorResponse).errorMessage).to(equal("permission not granted"))
                                            
                                            done()
            })
        }
    }
    
    func test_User_UpdateUserDetails_Address_Fails_Complete_Response(){
        
        let mapUserDetails : [String : Any] = ["firstName" : "John",
                                               "lastName" : "Doe",
                                               "address" : [ "" : ""] ]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_details_address_fails_response")
        
        //given
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetailsMap: mapUserDetails,
                                               userId: goodUserId,
                                               token: token)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.put, uri: uri ) , json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.userService.updateUser(details: mapUserDetails,
                                        token: self.token,
                                        completionHandler: { error in
                                            
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

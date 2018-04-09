//
//  User_UpdateUserDetails+ObjectProviderTests.swift
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
        
        
        //when
        stub(everything , json(JSON!, status: 204))
        
        waitUntil { done in
            self.userService.updateUser(details: mapUserDetails,
                                        userId: self.goodUserId,
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

        
        //when
        stub(everything, json(JSON!, status: 403))
        
        waitUntil { done in
            self.userService.updateUser(details: mapUserDetails,
                                        userId: self.goodUserId,
                                        token: self.token,
                                        completionHandler: { error in
                                            
                                            expect(error).toNot(beNil())
                                            expect((error as! ErrorWrapper).code).to(equal(1))
                                            expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                            expect((error as! ErrorWrapper).message).to(equal("permission not granted"))
                                            
                                            done()
            })
        }
    }
    
    func test_User_UpdateUserDetails_Address_Fails_Complete_Response(){
        
        //given
        let mapUserDetails : [String : Any] = ["firstName" : "John",
                                               "lastName" : "Doe",
                                               "address" : [ "" : ""] ]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_details_address_fails_response")
        
        
        //when
        stub(everything , json(JSON!, status: 400))
        
        waitUntil { done in
            self.userService.updateUser(details: mapUserDetails,
                                        userId: self.goodUserId,
                                        token: self.token,
                                        completionHandler: { error in
                                            
                                            expect(error).toNot(beNil())
                                            
                                            expect((error as! ErrorWrapper).code).to(equal(5))
                                            expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                                            expect((error as! ErrorWrapper).message).to(equal("child \"address\" fails because [child \"street\" fails because [\"street\" is required], child \"postCode\" fails because [\"postCode\" is required], child \"city\" fails because [\"city\" is required], child \"country\" fails because [\"country\" is required]]"))
                                            
                                            expect((error as! ErrorWrapper).invalid?.addressStreet).toNot(beNil())
                                            expect((error as! ErrorWrapper).invalid?.addressStreet?.code).to(equal(6))
                                            expect((error as! ErrorWrapper).invalid?.addressStreet?.codeMeaning).to(equal("missing"))
                                            expect((error as! ErrorWrapper).invalid?.addressStreet?.message).to(equal("\"street\" is required"))
                                            
                                            expect((error as! ErrorWrapper).invalid?.addressPostCode).toNot(beNil())
                                            expect((error as! ErrorWrapper).invalid?.addressPostCode?.code).to(equal(6))
                                            expect((error as! ErrorWrapper).invalid?.addressPostCode?.codeMeaning).to(equal("missing"))
                                            expect((error as! ErrorWrapper).invalid?.addressPostCode?.message).to(equal("\"postCode\" is required"))
                                            
                                            expect((error as! ErrorWrapper).invalid?.addressCity).toNot(beNil())
                                            expect((error as! ErrorWrapper).invalid?.addressCity?.code).to(equal(6))
                                            expect((error as! ErrorWrapper).invalid?.addressCity?.codeMeaning).to(equal("missing"))
                                            expect((error as! ErrorWrapper).invalid?.addressCity?.message).to(equal("\"city\" is required"))
                                            
                                            expect((error as! ErrorWrapper).invalid?.addressCountry).toNot(beNil())
                                            expect((error as! ErrorWrapper).invalid?.addressCountry?.code).to(equal(6))
                                            expect((error as! ErrorWrapper).invalid?.addressCountry?.codeMeaning).to(equal("missing"))
                                            expect((error as! ErrorWrapper).invalid?.addressCountry?.message).to(equal("\"country\" is required"))
                                            done()
            })
        }
    }
}

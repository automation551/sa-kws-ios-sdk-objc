//
//  User+ServiceTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 19/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class UserServiceTests: XCTestCase {
    
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
    
    //MARK: GET USER DETAILS
    
    func test_User_GetUserDetails_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"get_user_details_success_response")
        
        let request = UserDetailsRequest(environment: self.environment,
                                         userId: self.goodUserId,
                                         token: self.token)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            self.userService.getUser(userId: self.goodUserId,
                                     token: self.token,
                                     completionHandler: {  userDetailsResponse, error in
                                        
                                        //then
                                        expect(userDetailsResponse).toNot(beNil())
                                        
                                        expect(userDetailsResponse?.id).to(equal(25))
                                        expect(userDetailsResponse?.name).to(equal("genioustiger123"))
                                        expect(userDetailsResponse?.firstName).to(equal("John"))
                                        expect(userDetailsResponse?.lastName).to(equal("Doe"))
                                        expect(userDetailsResponse?.consentAgeForCountry).to(equal(13))
                                        expect(userDetailsResponse?.isMinor).to(beTrue())
                                        
                                        expect(userDetailsResponse?.address?.street).to(equal("Number 12"))
                                        expect(userDetailsResponse?.address?.city).to(equal("London"))
                                        expect(userDetailsResponse?.address?.postCode).to(equal("NW1 23L"))
                                        expect(userDetailsResponse?.address?.country).to(equal("United Kingdom"))
                                        expect(userDetailsResponse?.address?.countryCode).to(equal("GB"))
                                        expect(userDetailsResponse?.address?.countryName).to(equal("United Kingdom"))
                                        
                                        expect(userDetailsResponse?.dateOfBirth).to(equal("2012-03-02"))
                                        expect(userDetailsResponse?.gender).to(equal("male"))
                                        expect(userDetailsResponse?.language).to(equal("en"))
                                        expect(userDetailsResponse?.email).to(equal("john.doe@email"))
                                        
                                        expect(userDetailsResponse?.hasSetParentEmail).to(beTruthy())
                                        
                                        expect(userDetailsResponse?.applicationProfile?.name).to(equal("genioustiger123"))
                                        expect(userDetailsResponse?.applicationProfile?.customField1).to(equal(0))
                                        expect(userDetailsResponse?.applicationProfile?.customField2).to(equal(0))
                                        expect(userDetailsResponse?.applicationProfile?.avatarId).to(equal(0))
                                        
                                        expect(userDetailsResponse?.applicationPermissions?.address).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.firstName).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.lastName).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.email).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.streetAddress).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.city).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.postalCode).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.country).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.notifications).to(beTruthy())
                                        expect(userDetailsResponse?.applicationPermissions?.newsletter).to(beFalsy())
                                        expect(userDetailsResponse?.applicationPermissions?.competition).to(beFalsy())
                                        
                                        expect(userDetailsResponse?.points?.received).to(equal(600))
                                        expect(userDetailsResponse?.points?.total).to(equal(600))
                                        expect(userDetailsResponse?.points?.inApp).to(equal(600))
                                        expect(userDetailsResponse?.points?.balance).to(equal(600))
                                        expect(userDetailsResponse?.points?.pending).to(equal(1))
                                        
                                        expect(userDetailsResponse?.createdAt).to(equal("2018-01-19"))
                                        
                                        expect(error).to(beNil())
                                        
                                        done()
            })
        }
        
    }
    
    func test_User_GetUserDetails_BadHttp_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let request = UserDetailsRequest(environment: self.environment,
                                         userId: self.goodUserId,
                                         token: self.token)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!, status: 404))
        
        waitUntil { done in
            self.userService.getUser(userId: self.goodUserId,
                                     token: self.token,
                                     completionHandler: {  userDetailsResponse, error in
                                        
                                        //then
                                        expect(userDetailsResponse).to(beNil())
                                        
                                        expect(error).toNot(beNil())
                                        
                                        expect((error as! ErrorWrapper).code).to(equal(123))
                                        expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                                        
                                        done()
            })
        }
    }
    
    //MARK: UPDATE USER DETAILS
    
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
    func test_User_UpdateParentEmail_ValidRequestAndResponse(){
        
        let mapUserDetails : [String : Any] = ["parentEmail" : "parent.email@mail.com"]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_parent_email_success_response")
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetailsMap: mapUserDetails,
                                               userId: goodUserId,
                                               token: token)
        
        //when
        stub(everything, json(JSON!, status: 204))
        
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
    
    func test_User_UpdateParentEmail_Email_Already_Set_Response(){
        
        let mapUserDetails : [String : Any] = ["parentEmail" : "parent.email@mail.com"]
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_parent_email_already_set_response")
        
        //when
        stub(everything , json(JSON!, status: 409))
        
        waitUntil { done in
            self.userService.updateUser(details: mapUserDetails,
                                        userId: self.goodUserId,
                                        token: self.token,
                                        completionHandler: { error in
                                            
                                            
                                            expect(error).toNot(beNil())
                                            expect((error as! ErrorWrapper).code).to(equal(10))
                                            expect((error as! ErrorWrapper).codeMeaning).to(equal("conflict"))
                                            expect((error as! ErrorWrapper).message).to(equal("parentEmail already set"))
                                            expect((error as! ErrorWrapper).invalid?.parentEmail).toNot(beNil())
                                            expect((error as! ErrorWrapper).invalid?.parentEmail?.code).to(equal(10))
                                            expect((error as! ErrorWrapper).invalid?.parentEmail?.codeMeaning).to(equal("conflict"))
                                            expect((error as! ErrorWrapper).invalid?.parentEmail?.message).to(equal("parentEmail already set"))
                                            
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
                                        userId: self.goodUserId,
                                        token: self.token,
                                        completionHandler: { error in
                                            
                                            expect(error).toNot(beNil())
                                            expect((error as! ErrorWrapper).code).to(equal(5))
                                            expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                                            expect((error as! ErrorWrapper).message).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
                                            expect((error as! ErrorWrapper).invalid?.parentEmail).toNot(beNil())
                                            expect((error as! ErrorWrapper).invalid?.parentEmail?.code).to(equal(7))
                                            expect((error as! ErrorWrapper).invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
                                            expect((error as! ErrorWrapper).invalid?.parentEmail?.message).to(equal("\"parentEmail\" must be a valid email"))
                                            
                                            done()
            })
        }
    }
}

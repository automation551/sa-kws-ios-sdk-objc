//
//  User_GetUserDetails+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase
import SAProtobufs

class User_GetUser_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var userService: UserServiceProtocol!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
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
    
    func test_User_GetUserDetails_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"get_user_details_success_response")
        
        let request = UserDetailsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            self.userService.getUser(userId: self.goodUserId,
                                            token: self.goodToken,
                                            completionHandler: {  userDetailsResponse, error in
                                                
                                                //then
                                                expect(userDetailsResponse).toNot(beNil())
                                                
                                                expect(userDetailsResponse?.id).to(equal(25))
                                                expect(userDetailsResponse?.name).to(equal("genioustiger123"))
                                                expect(userDetailsResponse?.firstName).to(equal("John"))
                                                expect(userDetailsResponse?.lastName).to(equal("Doe"))
                                                
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
                                         userId: goodUserId,
                                         token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!, status: 404))
        
        waitUntil { done in
            self.userService.getUser(userId: self.goodUserId,
                                            token: self.goodToken,
                                            completionHandler: {  userDetailsResponse, error in
                                                
                                                //then
                                                expect(userDetailsResponse).to(beNil())
                                                
                                                expect(error).toNot(beNil())
                                                
                                                expect((error as! ErrorResponse).code).to(equal(123))
                                                expect((error as! ErrorResponse).codeMeaning).to(equal("notFound"))
                                                
                                                done()
            })
        }
    }
}

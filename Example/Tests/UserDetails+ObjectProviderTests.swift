//
//  UserDetails+ObjectProviderTests.swift
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

class UserDetails_ObjectProviderTests: XCTestCase {
    
    //class or data to test
    private var userService: UserService!
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
        self.userService = KWSSDK.getService(value: UserService.self, environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        userService = nil
        environment = nil
    }
    
    func test_Login_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"get_user_details_success_response")
        
        let request = UserDetailsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            
            self.userService.getUserDetails(userId: self.goodUserId,
                                            token: self.goodToken,
                                            callback: {  userDetailsResponse, error in
                                                
                                                //then
                                                expect(userDetailsResponse).toNot(beNil())
                                                
                                                expect(userDetailsResponse?.id).to(equal(25))
                                                expect(userDetailsResponse?.username).to(equal("username"))
                                                expect(userDetailsResponse?.firstName).to(equal("first_name"))
                                                expect(userDetailsResponse?.lastName).to(equal("last_name"))
                                                
                                                expect(userDetailsResponse?.address?.street).to(equal("street"))
                                                expect(userDetailsResponse?.address?.city).to(equal("city"))
                                                expect(userDetailsResponse?.address?.postCode).to(equal("postCode"))
                                                expect(userDetailsResponse?.address?.country).to(equal("country"))
                                                
                                                expect(userDetailsResponse?.dateOfBirth).to(equal("dob"))
                                                expect(userDetailsResponse?.gender).to(equal("male"))
                                                expect(userDetailsResponse?.language).to(equal("en"))
                                                expect(userDetailsResponse?.email).to(equal("email@email"))
                                                
                                                expect(userDetailsResponse?.hasSetParentEmail).to(beTruthy())
                                                
                                                expect(userDetailsResponse?.applicationProfile?.username).to(equal("username"))
                                                expect(userDetailsResponse?.applicationProfile?.customField1).to(equal(0))
                                                expect(userDetailsResponse?.applicationProfile?.customField2).to(equal(0))
                                                expect(userDetailsResponse?.applicationProfile?.avatarId).to(equal(0))
                                                
                                                expect(userDetailsResponse?.applicationPermissions?.accessAddress).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessFirstName).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessLastName).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessEmail).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessStreetAddress).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessCity).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessPostalCode).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.accessCountry).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.sendPushNotification).to(beTruthy())
                                                expect(userDetailsResponse?.applicationPermissions?.sendNewsletter).to(beFalsy())
                                                expect(userDetailsResponse?.applicationPermissions?.enterCompetitions).to(beFalsy())
                                                
                                                expect(userDetailsResponse?.points?.totalReceived).to(equal(600))
                                                expect(userDetailsResponse?.points?.total).to(equal(600))
                                                expect(userDetailsResponse?.points?.totalPointsReceivedInCurrentApp).to(equal(600))
                                                expect(userDetailsResponse?.points?.availableBalance).to(equal(600))
                                                expect(userDetailsResponse?.points?.pending).to(equal(1))
                                                
                                                expect(userDetailsResponse?.createdAt).to(equal("creation_date"))
                                                
                                                expect(error).to(beNil())
                                                
                                                done()
                                                
            })
        }
        
    }
    
    func test_UserDetails_BadHttp_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let request = UserDetailsRequest(environment: self.environment,
                                         userId: goodUserId,
                                         token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.userService.getUserDetails(userId: self.goodUserId,
                                            token: self.goodToken,
                                            callback: {  userDetailsResponse, error in
                                                
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

//
//  UserDetails+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//



import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class UserDetails_MappingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_UserDetails_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"get_user_details_success_response")
        
        let userDetailsResponse = try? UserDetails.decode(JSON!)
        
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
        
    }
    
    
    func test_UserDetails_Mapping_ErrorResponse_NotFound() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        
    }



}


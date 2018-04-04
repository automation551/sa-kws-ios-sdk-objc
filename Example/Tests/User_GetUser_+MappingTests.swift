//
//  User_GetUserDetails+MappingTests.swift
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

class User_GetUser_MappingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_User_GetUserDetails_Mapping_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"get_user_details_success_response")
        
        let userDetailsResponse = try? UserDetails.decode(JSON!)
        
        expect(userDetailsResponse).toNot(beNil())
        expect(userDetailsResponse?.id).to(equal(25))
        expect(userDetailsResponse?.name).to(equal("geniouspokemon123"))
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
        
        expect(userDetailsResponse?.applicationProfile?.name).to(equal("geniouspokemon123"))
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
    }
    
    func test_User_GetUserDetails_Mapping_ErrorResponse_NotFound() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
    }
}


//
//  CreateUser+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import Decodable
import protocol Decodable.Decodable
import KWSiOSSDKObjC

class CreateUser_DoUserCreation_MappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    //User creation mapping
    func test_CreateUser_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_success_response")
        
        let createUserResponse = try? CreateUserResponse.decode(JSON!)
        
        expect(createUserResponse).toNot(beNil())
        expect(createUserResponse?.id).to(equal(99))
        expect(createUserResponse?.token).to(equal("good_token"))
        
    }
    
    func test_CreateUser_BadUsername_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_username_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"username\" fails because [\"username\" length must be at least 3 characters long]"))
        expect(errorResponse?.invalid?.username?.code).to(equal(7))
        expect(errorResponse?.invalid?.username?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.username?.errorMessage).to(equal("\"username\" length must be at least 3 characters long"))
    }
    
    func test_CreateUser_BadUsernameConflict_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_conflict_username_taken_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(10))
        expect(errorResponse?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.errorMessage).to(equal("username already taken"))
        expect(errorResponse?.invalid?.username?.code).to(equal(10))
        expect(errorResponse?.invalid?.username?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.invalid?.username?.errorMessage).to(equal("username already taken"))
    }
    
    func test_CreateUser_BadTokenResponse(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_token_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
        
    }
    
    func test_CreateUser_BadPassword_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_password_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"password\" fails because [\"password\" length must be at least 8 characters long]"))
        expect(errorResponse?.invalid?.password?.code).to(equal(7))
        expect(errorResponse?.invalid?.password?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.password?.errorMessage).to(equal("\"password\" length must be at least 8 characters long"))
    }
    
    func test_CreateUser_BadDateOfBirth_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_dob_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"dateOfBirth\" fails because [\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/]"))
        expect(errorResponse?.invalid?.dateOfBirth?.code).to(equal(7))
        expect(errorResponse?.invalid?.dateOfBirth?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.dateOfBirth?.errorMessage).to(equal("\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/"))
    }
    
    
    func test_CreateUser_BadCountry_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_country_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"country\" fails because [\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/]"))
        expect(errorResponse?.invalid?.country?.code).to(equal(7))
        expect(errorResponse?.invalid?.country?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.country?.errorMessage).to(equal("\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/"))
    }
    
    func test_CreateUser_BadParentEmail_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_email_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.errorMessage).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
        expect(errorResponse?.invalid?.parentEmail?.code).to(equal(7))
        expect(errorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.parentEmail?.errorMessage).to(equal("\"parentEmail\" must be a valid email"))
    }
    
   
    
    
    func test_CreateUser_NotFound_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let errorResponse = try? ErrorResponse.decode(JSON!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
        
    }
    
}

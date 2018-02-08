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
        
        let complexErrorResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(complexErrorResponse).toNot(beNil())
        expect(complexErrorResponse?.code).to(equal(5))
        expect(complexErrorResponse?.codeMeaning).to(equal("validation"))
        expect(complexErrorResponse?.errorMessage).to(equal("child \"username\" fails because [\"username\" length must be at least 3 characters long]"))
        expect(complexErrorResponse?.invalid?.username?.code).to(equal(7))
        expect(complexErrorResponse?.invalid?.username?.codeMeaning).to(equal("invalidValue"))
        expect(complexErrorResponse?.invalid?.username?.errorMessage).to(equal("\"username\" length must be at least 3 characters long"))
    }
    
    func test_CreateUser_BadUsernameConflict_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_conflict_username_taken_response")
        
        let complexErrorResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(complexErrorResponse).toNot(beNil())
        expect(complexErrorResponse?.code).to(equal(10))
        expect(complexErrorResponse?.codeMeaning).to(equal("conflict"))
        expect(complexErrorResponse?.errorMessage).to(equal("username already taken"))
        expect(complexErrorResponse?.invalid?.username?.code).to(equal(10))
        expect(complexErrorResponse?.invalid?.username?.codeMeaning).to(equal("conflict"))
        expect(complexErrorResponse?.invalid?.username?.errorMessage).to(equal("username already taken"))
    }
    
    func test_CreateUser_BadTokenResponse(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_token_response")
        
        let simpleErrorResponse = try? SimpleErrorResponse.decode(JSON!)
        
        expect(simpleErrorResponse).toNot(beNil())
        expect(simpleErrorResponse?.errorCode).to(equal("invalid_token"))
        expect(simpleErrorResponse?.error).to(equal("The access token provided is invalid."))
        
    }
    
    func test_CreateUser_BadPassword_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_password_response")
        
        let complexErrorResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(complexErrorResponse).toNot(beNil())
        expect(complexErrorResponse?.code).to(equal(5))
        expect(complexErrorResponse?.codeMeaning).to(equal("validation"))
        expect(complexErrorResponse?.errorMessage).to(equal("child \"password\" fails because [\"password\" length must be at least 8 characters long]"))
        expect(complexErrorResponse?.invalid?.password?.code).to(equal(7))
        expect(complexErrorResponse?.invalid?.password?.codeMeaning).to(equal("invalidValue"))
        expect(complexErrorResponse?.invalid?.password?.errorMessage).to(equal("\"password\" length must be at least 8 characters long"))
    }
    
    func test_CreateUser_BadDateOfBirth_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_dob_response")
        
        let complexErrorResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(complexErrorResponse).toNot(beNil())
        expect(complexErrorResponse?.code).to(equal(5))
        expect(complexErrorResponse?.codeMeaning).to(equal("validation"))
        expect(complexErrorResponse?.errorMessage).to(equal("child \"dateOfBirth\" fails because [\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/]"))
        expect(complexErrorResponse?.invalid?.dateOfBirth?.code).to(equal(7))
        expect(complexErrorResponse?.invalid?.dateOfBirth?.codeMeaning).to(equal("invalidValue"))
        expect(complexErrorResponse?.invalid?.dateOfBirth?.errorMessage).to(equal("\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/"))
    }
    
    
    func test_CreateUser_BadCountry_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_country_response")
        
        let complexErrorResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(complexErrorResponse).toNot(beNil())
        expect(complexErrorResponse?.code).to(equal(5))
        expect(complexErrorResponse?.codeMeaning).to(equal("validation"))
        expect(complexErrorResponse?.errorMessage).to(equal("child \"country\" fails because [\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/]"))
        expect(complexErrorResponse?.invalid?.country?.code).to(equal(7))
        expect(complexErrorResponse?.invalid?.country?.codeMeaning).to(equal("invalidValue"))
        expect(complexErrorResponse?.invalid?.country?.errorMessage).to(equal("\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/"))
    }
    
    func test_CreateUser_BadParentEmail_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_email_response")
        
        let complexErrorResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(complexErrorResponse).toNot(beNil())
        expect(complexErrorResponse?.code).to(equal(5))
        expect(complexErrorResponse?.codeMeaning).to(equal("validation"))
        expect(complexErrorResponse?.errorMessage).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
        expect(complexErrorResponse?.invalid?.parentEmail?.code).to(equal(7))
        expect(complexErrorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
        expect(complexErrorResponse?.invalid?.parentEmail?.errorMessage).to(equal("\"parentEmail\" must be a valid email"))
    }
    
   
    
    
    func test_CreateUser_NotFound_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let notFoundResponse = try? ComplexErrorResponse.decode(JSON!)
        
        expect(notFoundResponse).toNot(beNil())
        expect(notFoundResponse?.code).to(equal(123))
        expect(notFoundResponse?.codeMeaning).to(equal("notFound"))
        
    }
    
}

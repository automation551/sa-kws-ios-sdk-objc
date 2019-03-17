//
//  CreateUser+MappingTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Nimble
import KWSiOSSDKObjC

class CreateUserMappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_CreateUser_ResponseSuccess() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_success_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let createUserResponse = try? JSONDecoder().decode(AuthUserResponseModel.self, from: jsonData!)
        
        expect(createUserResponse).toNot(beNil())
        expect(createUserResponse?.id).to(equal(170))
        expect(createUserResponse?.token).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOjUxMjEsImFwcElkIjozNTgsImNsaWVudElkIjoia3dzLXNkay10ZXN0aW5nIiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTI0NDgzMzQ5LCJleHAiOjE4Mzk4NDMzNDksImlzcyI6InN1cGVyYXdlc29tZSJ9.go6JGvx9TEdM963QwexhLmvjNQp-u1qlwQ9-o_N-KNBRwLtI3EJJOGo8DAv0gEt1HPJ4VYKHxlEk3pisaTLzOFQ0jCIK7_vqXWKNFr9Tj7DEUbh8Nq1I47JtCgDyfgCCwoMvGYcv3nUEqg0b0SXCrVYdyQvO1UWDNurAcT8Cfts8awkKcMETXR1-uDr1-EnyDX21IjWu9U7K9seclePYcdwbLVYCly81PM3ZTwfisutoBofDoGfnc33exymqVHB8U-_csvs11hiUVw6KAGTsD2SEI8k1sedUDq-GPXSMTPDrdFB7W4CGXEJsnKD54g8CFGnTKHvw2Oea-D48-KN-_w"))
    }
    
    func test_CreateUser_BadUsername_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_username_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"username\" fails because [\"username\" length must be at least 3 characters long]"))
        expect(errorResponse?.invalid?.username?.code).to(equal(7))
        expect(errorResponse?.invalid?.username?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.username?.message).to(equal("\"username\" length must be at least 3 characters long"))
    }
    
    func test_CreateUser_Bad_Username_Conflict_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_conflict_username_taken_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(10))
        expect(errorResponse?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.message).to(equal("username already taken"))
        expect(errorResponse?.invalid?.username?.code).to(equal(10))
        expect(errorResponse?.invalid?.username?.codeMeaning).to(equal("conflict"))
        expect(errorResponse?.invalid?.username?.message).to(equal("username already taken"))
    }
    
    func test_CreateUser_Bad_Token_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_invalid_token_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.errorCode).to(equal("invalid_token"))
        expect(errorResponse?.error).to(equal("The access token provided is invalid."))
    }
    
    func test_CreateUser_Bad_Password_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_password_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"password\" fails because [\"password\" length must be at least 8 characters long]"))
        expect(errorResponse?.invalid?.password?.code).to(equal(7))
        expect(errorResponse?.invalid?.password?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.password?.message).to(equal("\"password\" length must be at least 8 characters long"))
    }
    
    func test_CreateUser_Bad_Date_Of_Birth_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_dob_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"dateOfBirth\" fails because [\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/]"))
        expect(errorResponse?.invalid?.dateOfBirth?.code).to(equal(7))
        expect(errorResponse?.invalid?.dateOfBirth?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.dateOfBirth?.message).to(equal("\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/"))
    }
    
    func test_CreateUser_Bad_Country_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_country_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"country\" fails because [\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/]"))
        expect(errorResponse?.invalid?.country?.code).to(equal(7))
        expect(errorResponse?.invalid?.country?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.country?.message).to(equal("\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/"))
    }
    
    func test_CreateUser_Bad_Parent_Email_Response(){
        var JSON: Any?
        JSON = try? fixtureWithName(name:"create_user_bad_email_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(5))
        expect(errorResponse?.codeMeaning).to(equal("validation"))
        expect(errorResponse?.message).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
        expect(errorResponse?.invalid?.parentEmail?.code).to(equal(7))
        expect(errorResponse?.invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
        expect(errorResponse?.invalid?.parentEmail?.message).to(equal("\"parentEmail\" must be a valid email"))
    }
    
    func test_CreateUser_Not_Found_Response() {
        
        var JSON: Any?
        JSON = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: JSON!)
        let errorResponse = try? JSONDecoder().decode(ErrorWrapper.self, from: jsonData!)
        
        expect(errorResponse).toNot(beNil())
        expect(errorResponse?.code).to(equal(123))
        expect(errorResponse?.codeMeaning).to(equal("notFound"))
    }
}

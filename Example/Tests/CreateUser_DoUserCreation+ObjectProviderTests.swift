//
//  CreateUser+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 05/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class CreateUser_DoUserCreation_ObjectProviderTests: XCTestCase {
    
    /*
     Create User is a 2 step process - this is step 2
     The test here should be to test the provider through the Service (see Login Provider Test)
     In order to keep each step of create user tested individually, this test uses the CreateUserProvider resource
     instead of using CreateUserService
     */
    
    //class or data to test
    private var createUserResource: CreateUserProvider!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUsername: String = "good_username"
    private var badUsername: String = "bad_username"
    
    private var goodPassword: String = "good_password"
    private var badPassword: String = "bad_password"
    
    private var goodDOB: String = "good_dob"
    private var badDOB: String = "bad_dob"
    
    private var goodCountry: String = "good_country"
    private var badCountry: String = "bad_country"
    
    private var goodParentEmail: String = "good_email"
    private var badParentEmail: String = "bad_email"
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    private var badClientID: String = "bad_client_id"
    private var badClientSecret: String = "bad_client_secret"
    
    private var goodAppID: Int = 1
    private var badAppID: Int = -1
    
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        createUserResource = CreateUserProvider.init(environment: self.environment)
        
        
    }
    override func tearDown() {
        super.tearDown()
        createUserResource = nil
        environment = nil
    }
    
    
    //User Creation
    func test_CreateUser_ValidRequestAndResponse() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_success_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).toNot(beNil())
                                                    expect(createUserResponse?.token).to(equal("good_token"))
                                                    expect(createUserResponse?.id).to(equal(99))
                                                    
                                                    expect(error).to(beNil())
                                                    done()
                                                    
            })
        }
        
    }
    
    func test_CreateUser_BadToken_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_bad_token_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: badToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + badToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.badToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).errorCode).to(equal("invalid_token"))
                                                    expect((error as! ErrorResponse).error).to(equal("The access token provided is invalid."))
                                                    done()
                                                    
            })
        }
        
    }
    
    func test_CreateUser_BadHttp_Response() {
        
        let JSON: Any? = try? fixtureWithName(name: "generic_simpler_not_found_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(123))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("notFound"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    
    func test_CreateUser_ConflictUsername_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_conflict_username_taken_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 409))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                   
                                                    expect((error as! ErrorResponse).code).to(equal(10))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("conflict"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("username already taken"))
                                                    expect((error as! ErrorResponse).invalid?.username?.code).to(equal(10))
                                                    expect((error as! ErrorResponse).invalid?.username?.codeMeaning).to(equal("conflict"))
                                                    expect((error as! ErrorResponse).invalid?.username?.errorMessage).to(equal("username already taken"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    func test_CreateUser_BadUsername_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_bad_username_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: badUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.badUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(5))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("child \"username\" fails because [\"username\" length must be at least 3 characters long]"))
                                                    expect((error as! ErrorResponse).invalid?.username?.code).to(equal(7))
                                                    expect((error as! ErrorResponse).invalid?.username?.codeMeaning).to(equal("invalidValue"))
                                                    expect((error as! ErrorResponse).invalid?.username?.errorMessage).to(equal("\"username\" length must be at least 3 characters long"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    func test_CreateUser_BadPassword_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_bad_password_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: badPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.badPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(5))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("child \"password\" fails because [\"password\" length must be at least 8 characters long]"))
                                                    expect((error as! ErrorResponse).invalid?.password?.code).to(equal(7))
                                                    expect((error as! ErrorResponse).invalid?.password?.codeMeaning).to(equal("invalidValue"))
                                                    expect((error as! ErrorResponse).invalid?.password?.errorMessage).to(equal("\"password\" length must be at least 8 characters long"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    func test_CreateUser_BadDateOfBirth_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_bad_dob_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: badDOB,
                                        country: goodCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.badDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(5))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("child \"dateOfBirth\" fails because [\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/]"))
                                                    expect((error as! ErrorResponse).invalid?.dateOfBirth?.code).to(equal(7))
                                                    expect((error as! ErrorResponse).invalid?.dateOfBirth?.codeMeaning).to(equal("invalidValue"))
                                                    expect((error as! ErrorResponse).invalid?.dateOfBirth?.errorMessage).to(equal("\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    func test_CreateUser_BadCountry_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_bad_country_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: badCountry,
                                        parentEmail: goodParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.badCountry,
                                                   parentEmail: self.goodParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(5))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("child \"country\" fails because [\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/]"))
                                                    expect((error as! ErrorResponse).invalid?.country?.code).to(equal(7))
                                                    expect((error as! ErrorResponse).invalid?.country?.codeMeaning).to(equal("invalidValue"))
                                                    expect((error as! ErrorResponse).invalid?.country?.errorMessage).to(equal("\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    
    func test_CreateUser_BadParentEmail_Request() {
        
        let JSON: Any? = try? fixtureWithName(name: "create_user_bad_email_response")
        
        let request = CreateUserRequest(environment: self.environment,
                                        username: goodUsername,
                                        password: goodPassword,
                                        dateOfBirth: goodDOB,
                                        country: goodCountry,
                                        parentEmail: badParentEmail,
                                        token: goodToken,
                                        appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint + "?access_token=" + goodToken)"
        stub(http(.post, uri: uri), json(JSON!, status: 400))
        
        waitUntil { done in
            
            self.createUserResource.doUserCreation(environment: self.environment,
                                                   username: self.goodUsername,
                                                   password: self.goodPassword,
                                                   dateOfBirth: self.goodDOB,
                                                   country: self.goodCountry,
                                                   parentEmail: self.badParentEmail,
                                                   appId: self.goodAppID,
                                                   token: self.goodToken,
                                                   callback: { createUserResponse, error in
                                                    
                                                    //then
                                                    expect(createUserResponse).to(beNil())
                                                    
                                                    expect(error).toNot(beNil())
                                                    
                                                    expect((error as! ErrorResponse).code).to(equal(5))
                                                    expect((error as! ErrorResponse).codeMeaning).to(equal("validation"))
                                                    expect((error as! ErrorResponse).errorMessage).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
                                                    expect((error as! ErrorResponse).invalid?.parentEmail?.code).to(equal(7))
                                                    expect((error as! ErrorResponse).invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
                                                    expect((error as! ErrorResponse).invalid?.parentEmail?.errorMessage).to(equal("\"parentEmail\" must be a valid email"))
                                                    
                                                    done()
                                                    
            })
        }
    }
    
    
}

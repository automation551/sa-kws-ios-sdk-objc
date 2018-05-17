//
//  Auth+ServiceTests.swift
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

class AuthServiceTests: XCTestCase {
    
    // class or data to test
    private var service: AuthServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    private var goodUsername: String = "good_username"
    private var badUsername: String = "bad_username"
    
    private var goodPassword: String = "good_password"
    private var badPassword: String = "bad_password"
    
    private var goodToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhcHBJZCI6MzU4LCJjbGllbnRJZCI6Imt3cy1zZGstdGVzdGluZyIsInNjb3BlIjoibW9iaWxlQXBwIiwiaWF0IjoxNTI0NDgzMTgxLCJleHAiOjE1MjQ1Njk1ODEsImlzcyI6InN1cGVyYXdlc29tZSJ9.KIzj1aDotN6irP2E9xrmpBgwNVCYkV6f9J3W8LimMtG5Vu6NlV6dIj369ZyWshenmcJ5fXLxIQiGoNizkd_maGGQksRvR5ll1puysP2wEmtPqt9GBmrni8fzc_oQp3T9L_qwnFLkcNTHV0uY1meGttuKja9-1QfU9in-bwtX1G7Fp4KzeVCtt9zYVai1kvQsjGujyiN0zy9MPe9TBYkswQDEP0TcYyH1RsXsFA4Rfxea75yVUbpi7Lv4w1CdAPsl-J9I3G5GxOqumOE1ZTuzbWqjpB03a1xN-ahGXTGc2Gkh184QD8mFe_AVZFQQgUfxLM9IzBNE5rRLG_M41n-Ksg"
    private var badToken: String = "bad_token"
    
    private var badClientID: String = "bad_client_id"
    private var badClientSecret: String = "bad_client_secret"
    
    var dataProvider: AuthService!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvironment: self.environment)
        self.service = sdk.getService(withType: AuthServiceProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    //MARK: CREATE USER
    
    func test_CreateUser_Valid_Request_And_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_success_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
    
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!))
        
        waitUntil { done in
        
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).toNot(beNil())
                expect(model?.token).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOjUxMjEsImFwcElkIjozNTgsImNsaWVudElkIjoia3dzLXNkay10ZXN0aW5nIiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTI0NDgzMzQ5LCJleHAiOjE4Mzk4NDMzNDksImlzcyI6InN1cGVyYXdlc29tZSJ9.go6JGvx9TEdM963QwexhLmvjNQp-u1qlwQ9-o_N-KNBRwLtI3EJJOGo8DAv0gEt1HPJ4VYKHxlEk3pisaTLzOFQ0jCIK7_vqXWKNFr9Tj7DEUbh8Nq1I47JtCgDyfgCCwoMvGYcv3nUEqg0b0SXCrVYdyQvO1UWDNurAcT8Cfts8awkKcMETXR1-uDr1-EnyDX21IjWu9U7K9seclePYcdwbLVYCly81PM3ZTwfisutoBofDoGfnc33exymqVHB8U-_csvs11hiUVw6KAGTsD2SEI8k1sedUDq-GPXSMTPDrdFB7W4CGXEJsnKD54g8CFGnTKHvw2Oea-D48-KN-_w"))
                expect(model?.id).to(equal(170))
                expect(error).to(beNil())
                
                done()
            }
        }
    }
    
    func test_CreateUser_BadUsername_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_bad_username_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "a1", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"username\" fails because [\"username\" length must be at least 3 characters long]"))
                expect((error as! ErrorWrapper).invalid?.username?.code).to(equal(7))
                expect((error as! ErrorWrapper).invalid?.username?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorWrapper).invalid?.username?.message).to(equal("\"username\" length must be at least 3 characters long"))
                
                done()
            }
        }
    }
    
    func test_CreateUser_Bad_Username_Conflict_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_conflict_username_taken_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(10))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("conflict"))
                expect((error as! ErrorWrapper).message).to(equal("username already taken"))
                expect((error as! ErrorWrapper).invalid?.username?.code).to(equal(10))
                expect((error as! ErrorWrapper).invalid?.username?.codeMeaning).to(equal("conflict"))
                expect((error as! ErrorWrapper).invalid?.username?.message).to(equal("username already taken"))
                
                done()
            }
        }
    }
    
    func test_CreateUser_Bad_Token_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "generic_invalid_token_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).errorCode).to(equal("invalid_token"))
                expect((error as! ErrorWrapper).error).to(equal("The access token provided is invalid."))
                
                done()
            }
        }
    }
    
    func test_CreateUser_Bad_Password_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_bad_password_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"password\" fails because [\"password\" length must be at least 8 characters long]"))
                expect((error as! ErrorWrapper).invalid?.password?.code).to(equal(7))
                expect((error as! ErrorWrapper).invalid?.password?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorWrapper).invalid?.password?.message).to(equal("\"password\" length must be at least 8 characters long"))
                
                done()
            }
        }
    }
    
    func test_CreateUser_Bad_Date_Of_Birth_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_bad_dob_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "123456", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"dateOfBirth\" fails because [\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/]"))
                expect((error as! ErrorWrapper).invalid?.dateOfBirth?.code).to(equal(7))
                expect((error as! ErrorWrapper).invalid?.dateOfBirth?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorWrapper).invalid?.dateOfBirth?.message).to(equal("\"dateOfBirth\" with value \"a\" fails to match the required pattern: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/"))
                
                done()
            }
        }
    }
    
    func test_CreateUser_Bad_Country_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_bad_country_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "123456", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"country\" fails because [\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/]"))
                expect((error as! ErrorWrapper).invalid?.country?.code).to(equal(7))
                expect((error as! ErrorWrapper).invalid?.country?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorWrapper).invalid?.country?.message).to(equal("\"country\" with value \"a\" fails to match the required pattern: /^[A-Z]{2}$/"))
                
                done()
            }
        }
    }
    
    func test_CreateUser_Bad_Parent_Email_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "create_user_bad_email_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 401))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"parentEmail\" fails because [\"parentEmail\" must be a valid email]"))
                expect((error as! ErrorWrapper).invalid?.parentEmail?.code).to(equal(7))
                expect((error as! ErrorWrapper).invalid?.parentEmail?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorWrapper).invalid?.parentEmail?.message).to(equal("\"parentEmail\" must be a valid email"))
                done()
            }
        }
    }
    
    func test_CreateUser_Not_Found_Response(){
        
        let TEMP_ACCESS_TOKEN: Any? = try? fixtureWithName(name: "temp_access_token_success_response")
        let CREATE_USER: Any? = try? fixtureWithName(name: "generic_simpler_not_found_response")
        
        let tempAccessURI = "https://localhost:8080/oauth/token"
        
        let appID = 358
        let createURI = "https://localhost:8080/v1/apps/\(appID)/users?access_token=\(goodToken)"
        
        stub(http(.post, uri: tempAccessURI), json(TEMP_ACCESS_TOKEN!))
        stub(http(.post, uri: createURI), json(CREATE_USER!, status: 404))
        
        waitUntil { done in
            
            self.service.createUser(username: "username123", password: "testpwd", timeZone: nil, dateOfBirth: "2012-02-02", country: "GB", parentEmail: "parent.mail@mail.com") { (model, error) in
                
                expect(model).to(beNil())
                expect(error).toNot(beNil())
                
                expect((error as! ErrorWrapper).code).to(equal(123))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                
                done()
            }
        }
    }
    
    //MARK: LOGIN
    func test_Login_Valid_Request_And_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_success_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: goodPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: self.environment.clientSecret)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.post, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: {  loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).toNot(beNil())
                                    expect(loginResponse?.token).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOjUwNzMsImFwcElkIjozNTgsImNsaWVudElkIjoia3dzLXNkay10ZXN0aW5nIiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTI0NTU4NzY3LCJleHAiOjE4Mzk5MTg3NjcsImlzcyI6InN1cGVyYXdlc29tZSJ9.Is_paGut_gq7Zo5r0eWcH4GI3BCA8-eFiFurrb080O0xY0GWo2SIIR5FKf4_iDNVy_LM0x4j5kzDowl5gOZ7O3-KelA9MO6mpADl6eyVA109Z3ij3uZZU_Y7HRoA8XFL_TgUq_I7ZcpiXFhf4kzUEVEstkaBpEJXOFfcr9SedG7HD6r94zNKVaRGbS1x9Y8eOCdQf1ainizl0MEjjU7LFjUXv4eOc9Vj57N9oVEY2_cqd0No5Sa0sPUZaEVSuRQDR78dhBuLJKttgovGFdJZj7YgLOmjPaFvqHkpuS50h2oh_YP-v-gzSFItRPWqtDOIyHSMLOvoOb8-FeptveBXsw"))
                                    
                                    expect(error).to(beNil())
                                    
                                    done()
            })
        }
    }
    
    func test_Login_BadHttp_Response(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_simpler_not_found_response")
        
        let  request = LoginRequest(environment: self.environment,
                                    username: goodUsername,
                                    password: goodPassword,
                                    clientID: self.environment.clientID,
                                    clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: {  loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil())
                                    expect((error as! ErrorWrapper).code).to(equal(123))
                                    expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                                    
                                    done()
            })
        }
    }
    
    func test_Login_BadUsername_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: badUsername,
                                   password: goodPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: {  loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil());
                                    
                                    expect(error).toNot(beNil());
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_grant"))
                                    expect((error as! ErrorWrapper).error).to(equal("User credentials are invalid"))
                                    
                                    done()
            })
        }
    }
    
    func test_Login_BadPassword_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"login_bad_user_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: badPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: { loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil());
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_grant"))
                                    expect((error as! ErrorWrapper).error).to(equal("User credentials are invalid"))
                                    
                                    done()
            })
        }
        
    }
    
    func test_Login_BadClientID_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let  request = LoginRequest(environment: self.environment,
                                    username: goodUsername,
                                    password: goodPassword,
                                    clientID: badClientID,
                                    clientSecret: self.environment.clientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: { loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil())
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_client"))
                                    expect((error as! ErrorWrapper).error).to(equal("Client credentials are invalid"))
                                    
                                    done()
            })
        }
        
    }
    
    func test_Login_BadClientSecret_Request(){
        
        let JSON: Any? = try? fixtureWithName(name:"generic_bad_client_credentials_response")
        
        let request = LoginRequest(environment: self.environment,
                                   username: goodUsername,
                                   password: goodPassword,
                                   clientID: self.environment.clientID,
                                   clientSecret: badClientSecret)
        
        //when
        stub(http(.post, uri: "\(request.environment.domain + request.endpoint)"), json(JSON!, status: 400))
        
        waitUntil { done in
            self.service.loginUser(userName: self.goodUsername,
                                   password: self.goodPassword,
                                   completionHandler: { loginResponse, error in
                                    
                                    //then
                                    expect(loginResponse).to(beNil())
                                    
                                    expect(error).toNot(beNil())
                                    expect((error as! ErrorWrapper).errorCode).to(equal("invalid_client"))
                                    expect((error as! ErrorWrapper).error).to(equal("Client credentials are invalid"))
                                    
                                    done()
            })
        }
    }
}

//
//  Username+ServiceTests.swift
//  KWSiOSSDKObjC_Example
//
//  Created by Guilherme Mota on 08/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class UsernameServiceTests: XCTestCase {
    
    // class or data to test
    private var service: UsernameServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvironment: self.environment)
        self.service = sdk.getService(withType: UsernameServiceProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    //MARK: Get App Config
    func test_Random_Username_App_Config_Nil_Auth_Client_Id_Response(){
        
        let APP_CONFIG: Any? = try? fixtureWithName(name: "app_config_null_oauthclientid_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId=" + environment.clientID
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!, status: 401))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is required]"))
                expect((error as! ErrorWrapper).invalid?.oauthClientId?.code).to(equal(6))
                expect((error as! ErrorWrapper).invalid?.oauthClientId?.codeMeaning).to(equal("missing"))
                expect((error as! ErrorWrapper).invalid?.oauthClientId?.message).to(equal("\"oauthClientId\" is required"))
                
                done()
            })
        }
    }
    
    func test_Random_Username_App_Config_Empty_Auth_Client_Id_Response(){
        
        let APP_CONFIG: Any? = try? fixtureWithName(name: "app_config_empty_oauthclientid_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId=" + environment.clientID
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!, status: 401))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorWrapper).code).to(equal(5))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("validation"))
                expect((error as! ErrorWrapper).message).to(equal("child \"oauthClientId\" fails because [\"oauthClientId\" is not allowed to be empty]"))
                expect((error as! ErrorWrapper).invalid?.oauthClientId?.code).to(equal(7))
                expect((error as! ErrorWrapper).invalid?.oauthClientId?.codeMeaning).to(equal("invalidValue"))
                expect((error as! ErrorWrapper).invalid?.oauthClientId?.message).to(equal("\"oauthClientId\" is not allowed to be empty"))
                
                done()
            })
        }
    }
    
    func test_Random_Username_App_Config_App_Not_Found_Response(){
        
        let APP_CONFIG: Any? = try? fixtureWithName(name: "app_config_app_not_found_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId=" + environment.clientID
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!, status: 404))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorWrapper).code).to(equal(2))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                expect((error as! ErrorWrapper).message).to(equal("app not found."))
                
                done()
            })
        }
    }
    
    func test_Random_Username_App_Config_Generic_Not_Found_Response(){
        
        let APP_CONFIG: Any? = try? fixtureWithName(name: "generic_simpler_not_found_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId=" + environment.clientID
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!, status: 404))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorWrapper).code).to(equal(123))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                
                done()
            })
        }
    }
    
    //MARK: Fetch Random Username
    
    func test_RandomUsername_Do_Random_Username_Fetch_Response_Success(){
        
        let APP_CONFIG: Any? = try? fixtureWithName(name: "app_config_success_response")
        let RANDOM_USERNAME: Any? = try? fixtureWithName(name: "random_username_success_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId=" + environment.clientID
        
        let appID = 358
        let randomUsernameURI = "https://localhost:8080/v2/apps/\(appID)/random-display-name"
        
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!))
        stub(http(.get, uri:randomUsernameURI), json(RANDOM_USERNAME!))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).toNot(beNil())
                expect(model?.randomUsername).to(equal("{randomUsername:coolrandomusername123}"))
                expect(error).to(beNil())
                
                done()
            })
        }
    }
    
    func test_RandomUsername_Do_Random_Username_Fetch_Not_Found_Response(){
        
        let APP_CONFIG: Any? = try? fixtureWithName(name: "app_config_success_response")
        let RANDOM_USERNAME: Any? = try? fixtureWithName(name: "generic_simpler_not_found_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId=" + environment.clientID
        
        let appID = 358
        let randomUsernameURI = "https://localhost:8080/v2/apps/\(appID)/random-display-name"
        
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!))
        stub(http(.get, uri:randomUsernameURI), json(RANDOM_USERNAME!, status: 403))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).to(beNil())
                
                expect(error).toNot(beNil())
                expect((error as! ErrorWrapper).code).to(equal(123))
                expect((error as! ErrorWrapper).codeMeaning).to(equal("notFound"))
                
                done()
            })
        }
    }
}

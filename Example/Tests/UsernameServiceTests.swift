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
import SAProtobufs

class UsernameServiceTests: XCTestCase {
    
    // class or data to test
    private var service: UsernameServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvirnoment: self.environment)
        self.service = sdk.getService(withType: UsernameServiceProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
    }
    
    func test_Multiple_Stubs(){
        let APP_CONFIG: Any? = try? fixtureWithName(name: "app_config_success_response")
        let RANDOM_USERNAME: Any? = try? fixtureWithName(name: "random_username_success_response")
        
        let appConfigURI = "https://localhost:8080/v1/apps/config?oauthClientId" + environment.clientID
        
        let appID = 358
        let randomUsernameURI = "https://localhost:8080/v2/apps/\(appID)/random-display-name"
        
        stub(http(.get, uri:appConfigURI), json(APP_CONFIG!))
        stub(http(.get, uri:randomUsernameURI), json(RANDOM_USERNAME!))
        
        waitUntil { done in
            
            self.service.getRandomUsername(completionHandler: { (model, error) in
                
                expect(model).toNot(beNil())
                expect(error).to(beNil())
                
                done()
            })
        }
        
        
        
    }
}

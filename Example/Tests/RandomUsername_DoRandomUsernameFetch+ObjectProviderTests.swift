//
//  RandomUsername_DoRandomUsernameFetch+ObjectProviderTests.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 07/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase


class RandomUsername_DoRandomUsernameFetch_ObjectProviderTests : XCTestCase{
    
    /*
     Random Username is a 2 step process - this is step 2
     The test here should be to test the provider through the Service (see Login Provider Test)
     In order to keep each step of create user tested individually, this test uses the RandomUsernameProvider resource
     instead of using RandomUsernameService
     */
    
    // class or data to test
    private var resource: RandomUsernameProvider!
    private var environment: KWSNetworkEnvironment!
    
    private var goodAppID: Int = 1
    private var badAppID: Int = -1
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        resource = RandomUsernameProvider.init(environment: self.environment)
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        resource = nil
        environment = nil
    }
    
    func test_RandomUsername_DoRandomUsernameFetch_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name: "random_username_success_response")
        
        let request = RandomUsernameRequest(environment: self.environment,
                                            appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint)"
        
        
        stub(http(.get, uri: uri), json(JSON!))
        
        waitUntil { done in

            self.resource.fetchRandomUsernameFromBackend(environment: self.environment,appID: self.goodAppID, callback: { response, error in

                //then
                expect(response).toNot(beNil())
                
                expect(response?.randomUsername).toNot(beNil())
                expect(response?.randomUsername).to(equal("{randomUsername:coolrandomusername123}"))

                expect(error).to(beNil())

                done()
            })

        }
        
    }
    
    
    func test_RandomUsername_DoRandomUsernameFetch_NotFound_Response(){
        
        let JSON: Any? = try? fixtureWithName(name: "generic_simpler_not_found_response")
        
        let request = RandomUsernameRequest(environment: self.environment,
                                            appID: goodAppID)
        
        let uri = "\(request.environment.domain + request.endpoint)"
        
        
        stub(http(.get, uri: uri), json(JSON!, status: 404))
        
        waitUntil { done in
            
            self.resource.fetchRandomUsernameFromBackend(environment: self.environment,appID: self.goodAppID, callback: { response, error in
                
                //then
                expect(response).to(beNil())
                
                expect(error).toNot(beNil())
                
                expect((error as! ErrorResponse)).toNot(beNil())
                expect((error as! ErrorResponse).code).to(equal(123))
                expect((error as! ErrorResponse).codeMeaning).to(equal("notFound"))
                
                done()
            })
            
        }
        
    }
    
}

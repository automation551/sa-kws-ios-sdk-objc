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
        
        //TODO find a way of reading string in stub
//        stub(http(.get, uri: uri), json(JSON!))
//
//        waitUntil { done in
//
//            self.resource.fetchRandomUsernameFromBackend(environment: self.environment,appID: self.goodAppID, callback: { response, error in
//
//                //then
//                expect(response).toNot(beNil())
//
//
//
//                expect(error).to(beNil())
//
//                done()
//            })
//
//        }
        
    }
    
}

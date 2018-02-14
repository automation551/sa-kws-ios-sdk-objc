//
//  User_UpdateUserDetails+ObjectProvider.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 14/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble
import KWSiOSSDKObjC
import SAMobileBase

class User_UpdateUserDetails_ObjectProviderTests: XCTestCase {
    
    
    //class or data to test
    private var userService: UserService!
    private var environment: KWSNetworkEnvironment!
    
    private var goodUserId: NSInteger = 1
    private var badUserId: NSInteger = -1
    
    private var userDetails: UserDetaisl!
    
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        self.userService = KWSSDK.getService(value: UserService.self, environment: self.environment)
        
        
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        userService = nil
        environment = nil
    }
    
    func test_User_GetUserDetails_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"update_user_detail_success_response")
        
        let request = UpdateUserDetailsRequest(environment: self.environment,
                                               userDetails: UserDetails,
                                               userId: goodUserId,
                                               token: goodToken)
        
        //when
        let uri = "\(request.environment.domain + request.endpoint)"
        stub(http(.get, uri: uri ) , json(JSON!))
        
        waitUntil { done in
            
            self.userService.updateUserDetails(userId: self.goodUserId,
                                               token: self.goodToken,
                                               userDetails: UserDetails,
                                               callback: {  userDetailsResponse, error in
                                                
                                                expect(userDetailsResponse).to(beTrue())
                                                expect(error).to(beNil())
                                                
                                                done()
                                                
            })
        }
        
    }
}

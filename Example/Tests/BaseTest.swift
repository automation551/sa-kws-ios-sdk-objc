//
//  BaseTest.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 29/01/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import XCTest
import KWSiOSSDKObjC
import SAMobileBase

class BaseTest: XCTestCase {
    
    public var API: String = "https://stan-test-cluster.api.kws.superawesome.tv/"
    public var SINGLE_SIGN_ON: String = "https://stan-test-cluster.accounts.kws.superawesome.tv/"
    public var CLIENT_ID : String = "stan-test"
    public var CLIENT_SECRET = "DRYNvSStuSvnaDg0d3f9t17QybbpQqX4"
    
    var environment: UserKWSNetworkEnvironment? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        environment = UserKWSNetworkEnvironment(domain: API, appID: CLIENT_SECRET, mobileKey: CLIENT_ID)
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

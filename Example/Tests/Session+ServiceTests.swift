//
//  Session+ServiceTests.swift
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

class SessionServiceTests: XCTestCase {
    
    //mock or real data
    private let kTokenKey: String = "kwsSDK_LoggedUser_Token_key"
    
    // class or data to test
    private var service: SessionServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    let defaults = UserDefaults.standard
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvirnoment: self.environment)
        self.service = sdk.getService(withType: SessionServiceProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        environment = nil
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    func testServiceToNotBeNil() {
        expect(self.service).toNot(beNil())
    }
    
    func testServiceToSaveLoggedUser() {
        // given
        let mockUser = MockLoggedUser()
        
        // when
        let result = service.saveLoggedUser(user: mockUser)
        
        // then
        expect(result).to(beTrue())
        
        let expectedToken = defaults.object(forKey: kTokenKey)
        expect(expectedToken).toNot(beNil())
        
        if let expected1 = expectedToken as? String {
            expect(expected1).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE3MCwiYXBwSWQiOjIsImNsaWVudElkIjoic3Rhbi10ZXN0Iiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTIzMjA4MDQ1LCJleHAiOjE1MjMyOTQ0NDUsImlzcyI6InN1cGVyYXdlc29tZSJ9.VqacuRn-qPx03fkNrFCD-siPIY2WGwMepvHeYE_JRP4"))
        } else {
            fail()
        }
        
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    func testServiceToReadCorrectlyLoggedUser () {
        // given
        let mockUser = MockLoggedUser()
        let token = mockUser.token
        let userId = mockUser.id
        
        // when
        defaults.set(token, forKey: kTokenKey)
        
        let result = service.getLoggedUser()
        
        // then
        expect(result).toNot(beNil())
        expect(result?.token).toNot(beNil())
        expect(result?.token).to(equal("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE3MCwiYXBwSWQiOjIsImNsaWVudElkIjoic3Rhbi10ZXN0Iiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTIzMjA4MDQ1LCJleHAiOjE1MjMyOTQ0NDUsImlzcyI6InN1cGVyYXdlc29tZSJ9.VqacuRn-qPx03fkNrFCD-siPIY2WGwMepvHeYE_JRP4"))
        expect(result?.id).toNot(beNil())
        expect(result?.id).to(equal(170))
        
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    func testServiceToNotReadIncorrectlySavedLoggedUser() {
        // given
        let mockUser = BadLoggedUser()
        let token = mockUser.token
        
        // when
        defaults.set(token, forKey: kTokenKey)
        
        let result = service.getLoggedUser()
        
        // then
        expect(result).to(beNil())
        
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    func testServiceToReturnTrueOnCorrectlyLoggedUser() {
        let mockUser = MockLoggedUser()
        let token = mockUser.token
        let userId = mockUser.id
        
        // when
        defaults.set(token, forKey: kTokenKey)
        
        let result = service.isUserLoggedIn()
        
        // then
        expect(result).to(beTrue())
        
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    func testServiceToReturnFalseOnIncorrectlyLoggedUser() {
        let mockUser = BadLoggedUser()
        let token = mockUser.token
        
        // when
        defaults.set(token, forKey: kTokenKey)
        
        let result = service.isUserLoggedIn()
        
        // then
        expect(result).to(beFalse())
        
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    func testServiceToReturnFalseOnNoUserWhatsoever() {
        // when
        defaults.removeObject(forKey: kTokenKey)
        
        let result = service.isUserLoggedIn()
        
        // then
        expect(result).to(beFalse())
        
        self.defaults.removeObject(forKey: kTokenKey)
    }
    
    private struct MockLoggedUser: LoggedUserModelProtocol {
        var token: String
        var id: AnyHashable
        
        init(token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE3MCwiYXBwSWQiOjIsImNsaWVudElkIjoic3Rhbi10ZXN0Iiwic2NvcGUiOiJ1c2VyIiwiaWF0IjoxNTIzMjA4MDQ1LCJleHAiOjE1MjMyOTQ0NDUsImlzcyI6InN1cGVyYXdlc29tZSJ9.VqacuRn-qPx03fkNrFCD-siPIY2WGwMepvHeYE_JRP4",
             id: Int = 170) {
            self.token = token
            self.id = id
        }
    }
    
    private struct BadLoggedUser: LoggedUserModelProtocol {
        var token: String
        var id: AnyHashable
        
        init (token: String = "111.111.111",
              id: Int = 0 ) {
            self.token = token
            self.id = id
        }
    }
}

//
//  Scoring+ServiceTests.swift
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

class ScoringServiceTests: XCTestCase {
    
    //class or data to test
    private var scoringService: ScoreServiceProtocol!
    private var environment: ComplianceNetworkEnvironment!
    
    private var goodAppId: Int = 123
    private var badAppId: Int = -1
    
    private var goodToken: String = "good_token"
    private var badToken: String = "bad_token"
    
    override func setUp() {
        super.setUp()
        
        //given
        self.environment = GoodMockNetworkEnvironment()
        
        //when
        let sdk = ComplianceSDK(withEnvironment: self.environment)
        self.scoringService = sdk.getService(withType: ScoreServiceProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        scoringService = nil
        environment = nil
    }
    
    //MARK: GET SCORE
    
    func test_Scoring_GetScore_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"get_user_score_success_response")
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.scoringService.getScore(appId: self.goodAppId,
                                         token: self.goodToken,
                                         completionHandler:  { (score, error) in
                                            
                                            expect(score).toNot(beNil())
                                            expect(score?.score).to(equal(600))
                                            expect(score?.rank).to(equal(1))
                                            expect(error).to(beNil())
                                            
                                            done()
            })
        }
    }
    
    func test_Scoring_GetScore_BadToken_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.scoringService.getScore(appId: self.goodAppId,
                                         token: self.badToken,
                                         completionHandler:  { (score, error) in
                                            
                                            expect(score).to(beNil())
                                            expect(error).toNot(beNil())
                                            expect((error as! ErrorWrapper).errorCode).to(equal("invalid_token"))
                                            expect((error as! ErrorWrapper).error).to(equal("The access token provided is invalid."))
                                            
                                            done()
            })
        }
    }
    
    func test_Scoring_GetScore_BadClientId_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.scoringService.getScore(appId: self.badAppId,
                                         token: self.goodToken,
                                         completionHandler:  { (score, error) in
                                            
                                            expect(score).to(beNil())
                                            expect(error).toNot(beNil())
                                            expect((error as! ErrorWrapper).code).to(equal(1))
                                            expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                            expect((error as! ErrorWrapper).message).to(equal("operation not supported for this client"))
                                            
                                            done()
            })
        }
    }
    
    //MARK: GET LEADERS
    
    func test_Scoring_GetLeaders_ValidRequestAndResponse(){
        
        let JSON: Any? = try? fixtureWithName(name:"get_leaders_success_response")
        
        //when
        stub(everything , json(JSON!))
        
        waitUntil { done in
            
            self.scoringService.getLeaderboard(appId: self.goodAppId,
                                               token: self.goodToken,
                                               completionHandler:  { (leader, error) in
                                                
                                                expect(leader).toNot(beNil())
                                                
                                                expect(leader?.results).toNot(beNil())
                                                expect(leader?.results[0].name).to(equal("testuser9112"))
                                                expect(leader?.results[0].score).to(equal(540))
                                                expect(leader?.results[0].rank).to(equal(1))
                                                
                                                expect(leader?.results[1].name).to(equal("testusr472"))
                                                expect(leader?.results[1].score).to(equal(40))
                                                expect(leader?.results[1].rank).to(equal(2))
                                                
                                                expect(leader?.count).to(equal(2))
                                                expect(leader?.offset).to(equal(0))
                                                expect(leader?.limit).to(equal(1000))
                                                expect(error).to(beNil())
                                                
                                                done()
            })
        }
    }
    
    func test_Scoring_GetLeaders_BadToken_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_invalid_token_response")
        
        //when
        stub(everything , json(JSON!, status: 401))
        
        waitUntil { done in
            
            self.scoringService.getLeaderboard(appId: self.goodAppId,
                                               token: self.badToken,
                                               completionHandler:  { (leader, error) in
                                                
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).errorCode).to(equal("invalid_token"))
                                                expect((error as! ErrorWrapper).error).to(equal("The access token provided is invalid."))
                                                
                                                done()
            })
        }
    }
    
    func test_Scoring_GetLeaders_BadClientId_Response(){
        let JSON: Any? = try? fixtureWithName(name:"generic_operation_not_supported_for_client_response")
        
        //when
        stub(everything , json(JSON!, status: 403))
        
        waitUntil { done in
            
            self.scoringService.getLeaderboard(appId: self.badAppId,
                                               token: self.goodToken,
                                               completionHandler:  { (leader, error) in
                                                
                                                expect(leader).to(beNil())
                                                expect(error).toNot(beNil())
                                                expect((error as! ErrorWrapper).code).to(equal(1))
                                                expect((error as! ErrorWrapper).codeMeaning).to(equal("forbidden"))
                                                expect((error as! ErrorWrapper).message).to(equal("operation not supported for this client"))
                                                
                                                done()
            })
        }
    }
}

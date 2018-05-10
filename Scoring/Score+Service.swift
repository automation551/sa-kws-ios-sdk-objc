//
//  Score+Service.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class ScoreService: NSObject, ScoreServiceProtocol {
    
    var environment: ComplianceNetworkEnvironment
    
    public init(environment: ComplianceNetworkEnvironment) {
        self.environment = environment
    }
    
    public func getScore(appId: Int, token: String, completionHandler: @escaping (ScoreModelProtocol?, Error?) -> ()) {
        
        let getScoreNetworkRequest = GetUserScoreRequest(environment: environment, appId: appId, token: token)
        
        let networktask = NetworkTask()
        let parseTask = ParseJsonTask<ScoreModel>()
        
        let future = networktask
            .execute(input: getScoreNetworkRequest)
            .map { (result: Result<String>) -> Result <ScoreModel> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
                break
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
    
    public func getLeaderboard(appId: Int, token: String, completionHandler: @escaping (LeaderWrapperModelProtocol?, Error?) -> ()) {
        
        let leaderBoardNetworkRequest = LeadersRequest(environment: environment, appId: appId, token: token)

        let networktask = NetworkTask()
        let parseTask = ParseJsonTask<LeadersWrapper>()

        let future = networktask
            .execute(input: leaderBoardNetworkRequest)
            .map { (result: Result<String>) -> Result <LeadersWrapper> in
                return result.then(parseTask.execute)
        }

        future.onResult { result in

            switch result {
            case .success(let value):
                completionHandler(value,nil)
                break
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
}

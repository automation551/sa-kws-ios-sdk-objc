//
//  Username+Service.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class UsernameService: NSObject, UsernameServiceProtocol {
    
    var environment: ComplianceNetworkEnvironment
    
    public init(environment: ComplianceNetworkEnvironment) {
        self.environment = environment
    }
    
    public func getRandomUsername(completionHandler: @escaping (RandomUsernameModelProtocol?, Error?) -> ()) {
        
        let getAppConfigNetworkRequest = AppConfigRequest(environment: environment,
                                                          clientID: environment.clientID)
        
        let parseTask = ParseJsonTask<AppConfigWrapper>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: getAppConfigNetworkRequest)
            .map { (result: Result<String>) -> Result <AppConfigWrapper> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                let appID = value.app.id
                self.fetchRandomUsernameFromBackend(environment: self.environment, appID: appID, completionHandler: completionHandler)
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)                
            }
        }
    }
    
    private func fetchRandomUsernameFromBackend(environment: ComplianceNetworkEnvironment,
                                               appID: Int,
                                               completionHandler: @escaping (RandomUsernameModel?, Error?) -> ()){
        
        let getRandomUsernameNetworkRequest = RandomUsernameRequest(environment:environment,
                                                                    appID:appID)
        
        let networkTask = NetworkTask()
        let future = networkTask.execute(input: getRandomUsernameNetworkRequest)
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                
                let parsedResponseString = value.replacingOccurrences(of: "\"", with: "")
                
                if !(parsedResponseString.isEmpty) {
                    completionHandler(RandomUsernameModel(randomUsername: parsedResponseString), nil)
                } else {
                    completionHandler(RandomUsernameModel(randomUsername: value), nil)
                }
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error as! PrintableErrorProtocol)
                completionHandler(nil, mappedError)
            }
        }
    }
    
    public func verifiyUsername(username: String, completionHandler: @escaping (VerifiedUsernameModelProtocol?, Error?) -> ()) {        
        //not used
    }
}

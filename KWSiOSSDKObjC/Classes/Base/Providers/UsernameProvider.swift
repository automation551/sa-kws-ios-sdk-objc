//
//  RandomUsernameProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class UsernameProvider: NSObject, UsernameServiceProtocol {
    
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func getRandomUsername(completionHandler: @escaping (RandomUsernameModelProtocol?, Error?) -> ()) {
        
        let getAppConfigNetworkRequest = AppConfigRequest(environment: environment,
                                                          clientID: environment.mobileKey)
        
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
                break
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
    
    private func fetchRandomUsernameFromBackend(environment: KWSNetworkEnvironment,
                                               appID: Int,
                                               completionHandler: @escaping (RandomUsername?, Error?) -> ()){
        
        let getRandomUsernameNetworkRequest = RandomUsernameRequest(environment:environment,
                                                                    appID:appID)
        
        let networkTask = NetworkTask()
        let future = networkTask.execute(input: getRandomUsernameNetworkRequest)
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                
                let parsedResponseString = value.replacingOccurrences(of: "\"", with: "")
                
                if (parsedResponseString != nil && !(parsedResponseString.isEmpty)){
                    completionHandler(RandomUsername(randomUsername: parsedResponseString), nil)
                } else {
                    completionHandler(RandomUsername(randomUsername: value), nil)
                }
                break
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
    
    public func verifiyUsername(username: String, completionHandler: @escaping (VerifiedUsernameModelProtocol?, Error?) -> ()) {        
        //not used
    }
}

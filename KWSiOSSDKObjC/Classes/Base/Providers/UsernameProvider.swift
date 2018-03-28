//
//  RandomUsernameProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

@objc public class UsernameProvider: NSObject, UsernameServiceProtocol {
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
        
    }
    
    public func getRandomUsername(completionHandler: @escaping (RandomUsernameModelProtocol?, Error?) -> ()) {
        
        let getAppConfigNetworkRequest = AppConfigRequest(environment: environment,
                                                          clientID: environment.mobileKey)
        
        let parseTask = ParseJsonTask<AppConfigWrapper>()
        networkTask = NetworkTask()
        
        let future = networkTask.execute(input: getAppConfigNetworkRequest)
            .map { (result: Result<String>) -> Result<AppConfigWrapper> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                
                let appId = mappedResponse.app.id
                
                self.fetchRandomUsernameFromBackend(environment: self.environment, appID: appId, completionHandler: completionHandler)
                
                break
            case .error(let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                
                break
            }
        }
        
    }
    
    
    public func fetchRandomUsernameFromBackend(environment: KWSNetworkEnvironment,
                                               appID: Int,
                                               completionHandler: @escaping (RandomUsername?, Error?) -> ()){
        
        
        let getRandomUsernameNetworkRequest = RandomUsernameRequest(environment:environment,
                                                                    appID:appID)
        networkTask = NetworkTask()
        
        let future = networkTask.execute(input: getRandomUsernameNetworkRequest)
        
        future.onResult{ (result) in
            
            switch (result){
            case .success(let mappedResponse):
                
                let parsedResponseString = mappedResponse.replacingOccurrences(of: "\"", with: "")
                
                if ( parsedResponseString != nil && !(parsedResponseString.isEmpty) ){
                    completionHandler(RandomUsername(randomUsername: parsedResponseString), nil)
                } else {
                    completionHandler(RandomUsername(randomUsername: mappedResponse), nil)
                }
                
                break
                
            case .error(let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                
                break
            }
        }
    }
    
    public func verifiyUsername(username: String, completionHandler: @escaping (VerifiedUsernameModelProtocol?, Error?) -> ()) {
        
        //not used
        
    }
    
}



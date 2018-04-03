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
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
        
    }
    
    public func getRandomUsername(completionHandler: @escaping (RandomUsernameModelProtocol?, Error?) -> ()) {
        
        getAppConfigDetails(environment: environment){ appConfigResponse, error in
            
            if (appConfigResponse?.app != nil && error == nil) {
                
                let appID = appConfigResponse?.app.id
                
                self.fetchRandomUsernameFromBackend(environment: self.environment, /*this will be improved*/ appID: appID!, completionHandler: completionHandler)
                
            } else {
                completionHandler(nil,error)
            }
            
        }
        
    }
    
    
    public func getAppConfigDetails(environment: KWSNetworkEnvironment,
                                    completionHandler: @escaping (AppConfigWrapper?, Error?) -> ()){
        
        let getAppConfigNetworkRequest = AppConfigRequest(environment: environment,
                                                          clientID: environment.mobileKey)
        
        networkTask.execute(request: getAppConfigNetworkRequest){ getAppConfigNetworkResponse in
            
            if let json = getAppConfigNetworkResponse.response, getAppConfigNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                let parseTask = JSONParseTask<AppConfigWrapper>()
                
                if let getAppConfigResponseObject = parseTask.execute(request: parseRequest){
                    completionHandler(getAppConfigResponseObject, nil)
                }else{
                    completionHandler(nil, KWSBaseError.JsonParsingError)
                }
                
                
            }else{
                if let errorResponse = getAppConfigNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(nil, mappedResponse)
                    
                } else {
                    completionHandler(nil, getAppConfigNetworkResponse.error)
                }
            }
        }
    }
    
    
    
    public func fetchRandomUsernameFromBackend(environment: KWSNetworkEnvironment,
                                               appID: Int,
                                               completionHandler: @escaping (RandomUsername?, Error?) -> ()){
        
        
        let getRandomUsernameNetworkRequest = RandomUsernameRequest(environment:environment,
                                                                    appID:appID)
        
        networkTask.execute(request: getRandomUsernameNetworkRequest){ getRandomUsernameNetworkResponse in
            
            let responseString = getRandomUsernameNetworkResponse.response
            
            if let json = responseString, getRandomUsernameNetworkResponse.error == nil{
                
                let parsedResponseString = responseString?.replacingOccurrences(of: "\"", with: "")
                
                if (parsedResponseString != nil && !(parsedResponseString?.isEmpty)!){
                    completionHandler(RandomUsername(randomUsername: parsedResponseString), nil)
                } else {
                    completionHandler(RandomUsername(randomUsername: responseString), nil)
                }
                
            } else {
                if let errorResponse = getRandomUsernameNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(nil, mappedResponse)
                    
                } else {
                    completionHandler(nil, getRandomUsernameNetworkResponse.error)
                }
            }
        }
        
    }
    
    public func verifiyUsername(username: String, completionHandler: @escaping (VerifiedUsernameModelProtocol?, Error?) -> ()) {
        
        //not used
        
    }
    
}



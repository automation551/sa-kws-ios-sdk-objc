//
//  RandomUsernameProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase

@objc public class RandomUsernameProvider: NSObject, RandomUsernameService {
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
        
    }
    
    
    public func getRandomUsername(callback: @escaping (RandomUsernameResponse?, Error?) -> ()) {
        
        getAppConfigDetails(environment: environment){ appConfigResponse, error in
            
            if (appConfigResponse?.app != nil && error == nil) {
                
                let appID = appConfigResponse?.app?.id
                
                self.fetchRandomUsernameFromBackend(environment: self.environment, appID: appID!, callback: callback)
                
            } else {
                callback(nil,error)
            }
            
        }
        
    }
    
    
    public func getAppConfigDetails(environment: KWSNetworkEnvironment,
                             callback: @escaping (AppConfigResponse?, Error?) -> ()){
        
        let getAppConfigNetworkRequest = AppConfigRequest(environment: environment,
                                                          clientID: environment.mobileKey)
        
        networkTask.execute(request: getAppConfigNetworkRequest){ getAppConfigNetworkResponse in
            
            if let json = getAppConfigNetworkResponse.response, getAppConfigNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                if getAppConfigNetworkResponse.success{
                    
                    let parseTask = JSONParseTask<AppConfigResponse>()
                    
                    if let getAppConfigResponseObject = parseTask.execute(request: parseRequest){
                        callback(getAppConfigResponseObject, nil)
                    }else{
                        callback(nil, KWSBaseError.JsonParsingError)
                    }
                    
                }else{
                    let parseTask = JSONParseTask<SimpleErrorResponse>()
                    
                    if let mappedResponse = parseTask.execute(request: parseRequest) {
                        callback(nil, mappedResponse)
                    } else {
                        callback(nil, KWSBaseError.JsonParsingError)
                    }
                }
                
            }else{
                // pass the network error forward through the callback to the user
                callback(nil, getAppConfigNetworkResponse.error)
                print("request \(getAppConfigNetworkRequest.environment.domain)\(getAppConfigNetworkRequest.endpoint), generated error:\(getAppConfigNetworkResponse.error ?? "unknown error" as! Error)")
            }
            
        }
        
    }
    
    
    
    public func fetchRandomUsernameFromBackend(environment: KWSNetworkEnvironment,
                                               appID: Int,
                                               callback: @escaping (RandomUsernameResponse?, Error?) -> ()){
        
        
        let getRandomUsernameNetworkRequest = RandomUsernameRequest(environment:environment,
                                                                    appID:appID)
        
        networkTask.execute(request: getRandomUsernameNetworkRequest){ getRandomUsernameNetworkResponse in
            
            let responseString = getRandomUsernameNetworkResponse.response
            
            if let json = responseString, getRandomUsernameNetworkResponse.error == nil{
                
                let parsedResponseString = responseString?.replacingOccurrences(of: "\"", with: "")
                
                if(parsedResponseString != nil && !(parsedResponseString?.isEmpty)!){
                    callback(RandomUsernameResponse(randomUsername: parsedResponseString), nil)
                }else{
                    callback(RandomUsernameResponse(randomUsername: responseString), nil)
                }
                
                
            }else{
                callback(nil, getRandomUsernameNetworkResponse.error)
            }
        }
        
    }
    
}



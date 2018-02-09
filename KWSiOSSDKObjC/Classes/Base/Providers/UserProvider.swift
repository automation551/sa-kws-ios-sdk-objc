//
//  UserProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAMobileBase


@objc public class UserProvider: NSObject, UserService{
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    public func getUserDetails(userId: NSInteger, token: String, callback: @escaping (UserDetailsResponse?, Error?) -> ()) {
        
        let getUserDetailsNetworkRequest = UserDetailsRequest(environment: environment,
                                                              userId: userId,
                                                              token: token)
        
        networkTask.execute(request: getUserDetailsNetworkRequest){ getUserDetailsNetworkResponse in
            
            if let json = getUserDetailsNetworkResponse.response, getUserDetailsNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                if getUserDetailsNetworkResponse.success{
                    
                    let parseTask = JSONParseTask<UserDetailsResponse>()
                    
                    if let getUserDetailsResponseObject = parseTask.execute(request: parseRequest){
                        callback(getUserDetailsResponseObject, nil)
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
                callback(nil, getUserDetailsNetworkResponse.error)
                print("request \(getUserDetailsNetworkRequest.environment.domain)\(getUserDetailsNetworkRequest.endpoint), generated error:\(getUserDetailsNetworkResponse.error ?? "unknown error" as! Error)")
            }
            
        }
        
    }
    
    
    
    
}

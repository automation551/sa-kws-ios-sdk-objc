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
    
    public func getUserDetails(userId: NSInteger, token: String, callback: @escaping (UserDetails?, Error?) -> ()) {
        
        let getUserDetailsNetworkRequest = UserDetailsRequest(environment: environment,
                                                              userId: userId,
                                                              token: token)
        
        networkTask.execute(request: getUserDetailsNetworkRequest){ getUserDetailsNetworkResponse in
            
            if let json = getUserDetailsNetworkResponse.response, getUserDetailsNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                let parseTask = JSONParseTask<UserDetails>()
                
                if let getUserDetailsResponseObject = parseTask.execute(request: parseRequest){
                    callback(getUserDetailsResponseObject, nil)
                } else {
                    callback(nil, KWSBaseError.JsonParsingError)
                }
                
            }else{
                // pass the network error forward through the callback to the user
                let jsonParseRequest = JsonParseRequest.init(withRawData: (getUserDetailsNetworkResponse.error?.message)!)
                let parseTask = JSONParseTask<ErrorResponse>()
                
                if let mappedResponse = parseTask.execute(request: jsonParseRequest) {
                    callback(nil, mappedResponse)
                } else {
                    callback(nil, getUserDetailsNetworkResponse.error)
                }
            }
            
        }
        
    }
    
    
    public func updateUserDetails(userId: Int, token: String, userDetails: UserDetails, callback: @escaping (Bool, Error?) -> ()) {
        
        let upddateUserDetailsNetworkRequest = UpdateUserDetailsRequest(environment: environment,
                                                                        userDetails: userDetails,
                                                                        userId: userId,
                                                                        token: token)
        
        networkTask.execute(request: upddateUserDetailsNetworkRequest){ upddateUserDetailsNetworkResponse in
            
            //todo finish here
            if (upddateUserDetailsNetworkResponse.success && upddateUserDetailsNetworkResponse.error == nil) {
                callback(true, nil)
            } else {
                // pass the network error forward through the callback to the user
                let jsonParseRequest = JsonParseRequest.init(withRawData: (upddateUserDetailsNetworkResponse.error?.message)!)
                let parseTask = JSONParseTask<ErrorResponse>()
                
                if let mappedResponse = parseTask.execute(request: jsonParseRequest) {
                    callback(false, mappedResponse)
                } else {
                    callback(false, upddateUserDetailsNetworkResponse.error)
                }
            }
            
        }
        
    }
    
    
    
    
}

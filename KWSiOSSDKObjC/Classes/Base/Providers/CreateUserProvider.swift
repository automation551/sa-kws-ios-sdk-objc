//
//  CreateUserProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase

@objc public class CreateUserProvider: NSObject, CreateUserService {
    
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    
    public func createUser(username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, callback: @escaping (CreateUserResponse?, Error?) -> ()) {
        
        
        getTempAccessToken(environment: environment){ authResponse, error in
            
            if (authResponse?.token != nil && error == nil ){
                
                let token = authResponse?.token
                
                let base64req = ParseBase64Request(withBase64String: token)
                let base64Task = ParseBase64Task()
                let metadataJson = base64Task.execute(request: base64req)
                
                let parseJsonReq = JsonParseRequest(withRawData: metadataJson!)
                let parseJsonTask = JSONParseTask<MetadataKWS>()
                let metadata = parseJsonTask.execute(request: parseJsonReq)
                
                if(metadata != nil){
                    let appId = metadata?.appId
                    
                    //todo here Creation of user with temp access token
                    self.doUserCreation(environment: self.environment, username: username, password: password, dateOfBirth: dateOfBirth, country: country, parentEmail: parentEmail, appId: appId!, token: token!, callback: callback)
                }else{
                    callback(nil,KWSBaseError.JsonParsingError)
                }
                
            } else {
                callback(nil, error)
            }
            
        }
    }
    
    //TODO: Does it need to be public for tests? Is there a better way?
    open func getTempAccessToken(environment: KWSNetworkEnvironment, callback: @escaping (AuthResponse?, Error?) -> ()) {
        
        
        let getTempAccessTokenNetworkRequest = TempAccessTokenRequest(environment: environment,
                                                                      clientID: environment.mobileKey,
                                                                      clientSecret: environment.appID)
        
        networkTask.execute(request: getTempAccessTokenNetworkRequest){ getTempAccessTokenNetworkResponse in
            
            if let json = getTempAccessTokenNetworkResponse.response, getTempAccessTokenNetworkResponse.error == nil {
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                if getTempAccessTokenNetworkResponse.success{
                    
                    let parseTask = JSONParseTask<AuthResponse>()
                    
                    if let getTempAccessResponseObject = parseTask.execute(request: parseRequest){
                        callback(getTempAccessResponseObject, nil)
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
                callback(nil, getTempAccessTokenNetworkResponse.error)
                print("request \(getTempAccessTokenNetworkRequest.environment.domain)\(getTempAccessTokenNetworkRequest.endpoint), generated error:\(getTempAccessTokenNetworkResponse.error ?? "unknown error" as! Error)")
            }
        }
    }
    
    //TODO: Does it need to be public for tests? Is there a better way?
    open func doUserCreation(environment: KWSNetworkEnvironment,username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, appId: Int, token: String, callback: @escaping (CreateUserResponse?, Error?) -> ()) {
        
        
        let createUserNetworkRequest = CreateUserRequest(environment: environment,
                                                         username: username,
                                                         password: password,
                                                         dateOfBirth: dateOfBirth,
                                                         country: country,
                                                         parentEmail: parentEmail,
                                                         token: token,
                                                         appID: appId)
        
        networkTask.execute(request: createUserNetworkRequest){ createUserNetworkResponse in
            
            if let json = createUserNetworkResponse.response, createUserNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                if createUserNetworkResponse.success{
                    
                    let parseTask = JSONParseTask<CreateUserResponse>()
                    
                    if let createUserResponseObject = parseTask.execute(request: parseRequest){
                        callback(createUserResponseObject, nil)
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
                callback(nil, createUserNetworkResponse.error)
                print("request \(createUserNetworkRequest.environment.domain)\(createUserNetworkRequest.endpoint), generated error:\(createUserNetworkResponse.error ?? "unknown error" as! Error)")
            }
        }
    }
}

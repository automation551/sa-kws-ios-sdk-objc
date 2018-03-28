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
    
    
    public func createUser(username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, callback: @escaping (AuthUserResponse?, Error?) -> ()) {
        
        
        getTempAccessToken(environment: environment){ authResponse, error in
            
            if let token = authResponse?.token, error == nil {
                
                let base64req = ParseBase64Request(withBase64String: token)
                let base64Task = ParseBase64Task()
                let metadataJson = base64Task.execute(request: base64req)
                
                let parseJsonReq = JsonParseRequest(withRawData: metadataJson!)
                let parseJsonTask = JSONParseTask<MetadataKWS>()
                let metadata = parseJsonTask.execute(request: parseJsonReq)
                
                if let met = metadata, let appId = met.appId as? Int {
                    
                    self.doUserCreation(environment: self.environment, username: username, password: password, dateOfBirth: dateOfBirth, country: country, parentEmail: parentEmail, appId: appId, token: token, callback: callback)
                    
                }
                else {
                    callback(nil, KWSBaseError.JsonParsingError)
                }
            }
            else {
                callback(nil, error)
            }
            
        }
    }
    
    //TODO: Does it need to be public for tests? Is there a better way?
    public func getTempAccessToken(environment: KWSNetworkEnvironment, callback: @escaping (LoginAuthResponse?, Error?) -> ()) {
        
        
        let getTempAccessTokenNetworkRequest = TempAccessTokenRequest(environment: environment,
                                                                      clientID: environment.mobileKey,
                                                                      clientSecret: environment.appID)
        
        networkTask.execute(request: getTempAccessTokenNetworkRequest){ getTempAccessTokenNetworkResponse in
            
            if let json = getTempAccessTokenNetworkResponse.response, getTempAccessTokenNetworkResponse.error == nil {
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                
                let parseTask = JSONParseTask<AuthResponse>()
                
                if let getTempAccessResponseObject = parseTask.execute(request: parseRequest){
                    callback(getTempAccessResponseObject, nil)
                }else{
                    callback(nil, KWSBaseError.JsonParsingError)
                }                            
                
            }else{
                if let errorResponse = getTempAccessTokenNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    callback(nil, mappedResponse)
                    
                } else {
                    callback(nil, getTempAccessTokenNetworkResponse.error)
                }
            }
        }
    }
    
    //TODO: Does it need to be public for tests? Is there a better way?
    public func doUserCreation(environment: KWSNetworkEnvironment,username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, appId: Int, token: String, callback: @escaping (AuthUserResponse?, Error?) -> ()) {
        
        
        let createUserNetworkRequest = CreateUserRequest(environment: environment,
                                                         username: username,
                                                         password: password,
                                                         dateOfBirth: dateOfBirth,
                                                         country: country,
                                                         parentEmail: parentEmail,
                                                         token: token,
                                                         appID: appId)
        
        networkTask.execute(request: createUserNetworkRequest) { createUserNetworkResponse in
            
            if let json = createUserNetworkResponse.response, createUserNetworkResponse.error == nil {
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                let parseTask = JSONParseTask<CreateUserResponse>()
                
                if let createUserResponseObject = parseTask.execute(request: parseRequest){
                    callback(createUserResponseObject, nil)
                } else {
                    callback(nil, KWSBaseError.JsonParsingError)
                }
                
            } else {
                
                if let errorResponse = createUserNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    callback(nil, mappedResponse)
                    
                } else {
                   callback(nil, createUserNetworkResponse.error)
                }
            }
        }
    }
}


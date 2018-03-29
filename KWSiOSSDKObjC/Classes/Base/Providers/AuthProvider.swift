//
//  AuthProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

@objc public class AuthProvider: NSObject, AuthServiceProtocol {
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    public func loginUser(userName: String, password: String, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
                                                   username: userName,
                                                   password: password,
                                                   clientID: self.environment.mobileKey,
                                                   clientSecret: self.environment.appID)
        
        networkTask.execute(request: loginUserNetworkRequest) { loginUserNetworkResponse in
            
            if let json = loginUserNetworkResponse.response, loginUserNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                let parseTask = JSONParseTask<LoginAuthResponse>()
                
                if let loginResponseObject = parseTask.execute(request: parseRequest){
                    completionHandler(loginResponseObject,nil)
                } else {
                    completionHandler(nil,KWSBaseError.JsonParsingError)
                }
                
                
            } else {
                
                if let errorResponse = loginUserNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(nil, mappedResponse)
                    
                } else {
                    completionHandler(nil, loginUserNetworkResponse.error)
                }
            }
        }
    }
    
    public func createUser(username: String, password: String, timeZone: String?, dateOfBirth: String?, country: String?, parentEmail: String?, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        var dobValue = dateOfBirth ?? ""
        var countryValue = country ?? ""
        var parentEmailValue = parentEmail ?? ""
        
        getTempAccessToken(environment: environment){ authResponse, error in
            
            if let token = authResponse?.token, error == nil {
                
                let base64req = ParseBase64Request(withBase64String: token)
                let base64Task = ParseBase64Task()
                let metadataJson = base64Task.execute(request: base64req)
                
                let parseJsonReq = JsonParseRequest(withRawData: metadataJson!)
                let parseJsonTask = JSONParseTask<TokenData>()
                let metadata = parseJsonTask.execute(request: parseJsonReq)
                
                if let met = metadata, let appId = met.appId as? Int {
                    
                    self.doUserCreation(environment: self.environment, username: username, password: password, dateOfBirth: dobValue, country: countryValue, parentEmail: parentEmailValue, appId: appId, token: token, completionHandler: completionHandler)
                    
                }
                else {
                    completionHandler(nil, KWSBaseError.JsonParsingError)
                }
            }
            else {
                completionHandler(nil, error)
            }
            
        }
    }
    
    //TODO: Does it need to be public for tests? Is there a better way?
    public func getTempAccessToken(environment: KWSNetworkEnvironment, completionHandler: @escaping (AuthUserResponse?, Error?) -> ()) {
        
        
        let getTempAccessTokenNetworkRequest = TempAccessTokenRequest(environment: environment,
                                                                      clientID: environment.mobileKey,
                                                                      clientSecret: environment.appID)
        
        networkTask.execute(request: getTempAccessTokenNetworkRequest){ getTempAccessTokenNetworkResponse in
            
            if let json = getTempAccessTokenNetworkResponse.response, getTempAccessTokenNetworkResponse.error == nil {
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                
                
                let parseTask = JSONParseTask<AuthUserResponse>()
                
                if let getTempAccessResponseObject = parseTask.execute(request: parseRequest){
                    completionHandler(getTempAccessResponseObject, nil)
                }else{
                    completionHandler(nil, KWSBaseError.JsonParsingError)
                }
                
            }else{
                if let errorResponse = getTempAccessTokenNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(nil, mappedResponse)
                    
                } else {
                    completionHandler(nil, getTempAccessTokenNetworkResponse.error)
                }
            }
        }
    }
    
    //TODO: Does it need to be public for tests? Is there a better way?
    public func doUserCreation(environment: KWSNetworkEnvironment,username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, appId: Int, token: String, completionHandler: @escaping (AuthUserResponse?, Error?) -> ()) {
        
        
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
                
                let parseTask = JSONParseTask<AuthUserResponse>()
                
                if let createUserResponseObject = parseTask.execute(request: parseRequest){
                    completionHandler(createUserResponseObject, nil)
                } else {
                    completionHandler(nil, KWSBaseError.JsonParsingError)
                }
                
            } else {
                
                if let errorResponse = createUserNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(nil, mappedResponse)
                    
                } else {
                    completionHandler(nil, createUserNetworkResponse.error)
                }
            }
        }
    }
}


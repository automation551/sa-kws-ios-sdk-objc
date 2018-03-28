//
//  CreateUserProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

@objc public class CreateUserProvider: NSObject, AuthServiceProtocol {
    
    
    public func loginUser(userName: String, password: String, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        //todo here
    }
    
    public func createUser(username: String, password: String, timeZone: String?, dateOfBirth: String?, country: String?, parentEmail: String?, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let getTempAccessTokenNetworkRequest = TempAccessTokenRequest(environment: environment,
                                                                      clientID: environment.mobileKey,
                                                                      clientSecret: environment.appID)
        
        let parse = ParseJsonTask<LoginAuthResponse>()
        let network = NetworkTask()
        
        let future = network
            .execute(input: getTempAccessTokenNetworkRequest)
            .map { (result: Result<String>) -> Result<LoginAuthResponse> in
                return result.then(parse.execute)
        }
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                
                let token = mappedResponse.token
                let base64T = ParseBase64Task()
                let tokenT = ParseJsonTask<TokenData>()
                let result = base64T.execute(input: token).then(tokenT.execute)
                
                switch result {
                case .success(let tokenData):
                    let loggedUser = LoggedUser.init(token: token, userId: tokenData.userId)
                    completionHandler (loggedUser, nil)
                    break
                case .error(let error):
                    completionHandler (nil, error)
                    break
                }
                
                
                break
            case .error(let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                
                break
            }
            
        }
        
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
    
    
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
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


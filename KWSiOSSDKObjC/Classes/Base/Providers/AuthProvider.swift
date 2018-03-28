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
    
    
    public func loginUser(userName: String, password: String, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
                                                   username: userName,
                                                   password: password,
                                                   clientID: self.environment.mobileKey,
                                                   clientSecret: self.environment.appID)
        
        
        let parseTask = ParseJsonTask<AuthUserResponse>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: loginUserNetworkRequest)
            .map { (result: Result<String>) -> Result<AuthUserResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                completionHandler(mappedResponse, nil)
                break
            case .error(let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                
                break
            }
        }
    }
    
    public func createUser(username: String, password: String, timeZone: String?, dateOfBirth: String?, country: String?, parentEmail: String?, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        var dobValue = dateOfBirth ?? ""
        var countryValue = country ?? ""
        var parentEmailValue = parentEmail ?? ""
        
        let getTempAccessTokenNetworkRequest = TempAccessTokenRequest(environment: environment,
                                                                      clientID: environment.mobileKey,
                                                                      clientSecret: environment.appID)
        
        let parseTask = ParseJsonTask<LoginAuthResponse>()
        let network = NetworkTask()
        
        let future = network
            .execute(input: getTempAccessTokenNetworkRequest)
            .map { (result: Result<String>) -> Result<LoginAuthResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                
                let token = mappedResponse.token
                let base64T = ParseBase64Task()
                let tokenT = ParseJsonTask<TokenData>()
                let resultToken = base64T.execute(input: token).then(tokenT.execute)
                
                switch resultToken {
                case .success(let tokenData):
                    
                    let appId = tokenData.appId.intValue
                    
                    self.doUserCreation(environment: self.environment, username: username, password: password, dateOfBirth: dobValue, country: countryValue, parentEmail: parentEmailValue, appId: appId, token: token, completionHandler: completionHandler)
                    
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
    }
    
    
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
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
        
        
        let parseTask = ParseJsonTask<AuthUserResponse>()
        let network = NetworkTask()
        
        let future = network
            .execute(input: createUserNetworkRequest)
            .map { (result: Result<String>) -> Result<AuthUserResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                
                completionHandler(mappedResponse, nil)
                
                break
            case .error ( let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                
                break
            }
        }
    }
}


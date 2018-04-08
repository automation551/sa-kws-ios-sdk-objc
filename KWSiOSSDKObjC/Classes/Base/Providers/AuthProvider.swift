//
//  AuthProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs
import KWSiOSSDKObjC

public class AuthProvider: NSObject, AuthServiceProtocol {
    
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func loginUser(userName: String, password: String, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
                                                   username: userName,
                                                   password: password,
                                                   clientID: self.environment.mobileKey,
                                                   clientSecret: self.environment.appID)
        
        let parseTask = ParseJsonTask<LoginAuthResponse>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: loginUserNetworkRequest)
            .map { (result: Result<String>) -> Result<LoginAuthResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
                break
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
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
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: getTempAccessTokenNetworkRequest)
            .map { (result: Result<String>) -> Result <LoginAuthResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                
                let token = value.token
                
                let base64Task = ParseBase64Task()
                let parseTask = ParseJsonTask<TokenData>()
                let tokenResult = base64Task.execute(input: token).then(parseTask.execute)
                
                switch tokenResult {
                case .success(let tokenData):
                    let appId = tokenData.appId
                    
                    self.doUserCreation(environment: self.environment, username: username, password: password, dateOfBirth: dobValue, country: countryValue, parentEmail: parentEmailValue, appId: appId, token: token, completionHandler: completionHandler)
                    break
                case .error(let error):
                    let mappedError = Provider().mapErrorResponse(error: error)
                    completionHandler(nil, mappedError)
                    break
                }
                
                break
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
    
    private func doUserCreation(environment: KWSNetworkEnvironment,username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, appId: Int, token: String, completionHandler: @escaping (AuthUserResponse?, Error?) -> ()) {
        
        
        let createUserNetworkRequest = CreateUserRequest(environment: environment,
                                                         username: username,
                                                         password: password,
                                                         dateOfBirth: dateOfBirth,
                                                         country: country,
                                                         parentEmail: parentEmail,
                                                         token: token,
                                                         appID: appId)
        
        let parseTask = ParseJsonTask<AuthUserResponse>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: createUserNetworkRequest)
            .map { (result: Result<String>) -> Result<AuthUserResponse> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
                break
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
}


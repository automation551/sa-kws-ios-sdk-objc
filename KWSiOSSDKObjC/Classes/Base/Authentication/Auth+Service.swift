//
//  Auth+Service.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs
import KWSiOSSDKObjC

public class AuthService: NSObject, AuthServiceProtocol {
    
    var environment: ComplianceNetworkEnvironment
    
    public init(environment: ComplianceNetworkEnvironment) {
        self.environment = environment
    }
    
    public func loginUser(userName: String, password: String, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
                                                   username: userName,
                                                   password: password,
                                                   clientID: self.environment.clientID,
                                                   clientSecret: self.environment.clientSecret)
        
        let parseTask = ParseJsonTask<LoginAuthResponseModel>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: loginUserNetworkRequest)
            .map { (result: Result<String>) -> Result<LoginAuthResponseModel> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
            case .error(let error):
                let mappedError = BaseService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
            }
        }
    }
    
    public func createUser(username: String, password: String, timeZone: String?, dateOfBirth: String?, country: String?, parentEmail: String?, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        var dobValue = dateOfBirth ?? ""
        var countryValue = country ?? ""
        var parentEmailValue = parentEmail ?? ""
        
        let getTempAccessTokenNetworkRequest = TempAccessTokenRequest(environment: environment,
                                                                      clientID: environment.clientID,
                                                                      clientSecret: environment.clientSecret)
        
        let parseTask = ParseJsonTask<LoginAuthResponseModel>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: getTempAccessTokenNetworkRequest)
            .map { (result: Result<String>) -> Result <LoginAuthResponseModel> in
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
                case .error(let error):
                    let mappedError = BaseService().mapErrorResponse(error: error)
                    completionHandler(nil, mappedError)
                }
            case .error(let error):
                let mappedError = BaseService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
            }
        }
    }
    
    private func doUserCreation(environment: ComplianceNetworkEnvironment, username: String, password: String, dateOfBirth: String, country: String, parentEmail: String, appId: Int, token: String, completionHandler: @escaping (AuthUserResponseModel?, Error?) -> ()) {
        
        
        let createUserNetworkRequest = CreateUserRequest(environment: environment,
                                                         username: username,
                                                         password: password,
                                                         dateOfBirth: dateOfBirth,
                                                         country: country,
                                                         parentEmail: parentEmail,
                                                         token: token,
                                                         appID: appId)
        
        let parseTask = ParseJsonTask<AuthUserResponseModel>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: createUserNetworkRequest)
            .map { (result: Result<String>) -> Result<AuthUserResponseModel> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
            case .error(let error):
                let mappedError = BaseService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
            }
        }
    }
}


//
//  LoginProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

@objc public class LoginProvider: NSObject, LoginService {
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    
    
    public func loginUser(username: String, password: String, callback: @escaping (LoginAuthResponse?, Error?) -> ()) {
        
        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
                                                   username: username,
                                                   password: password,
                                                   clientID: self.environment.mobileKey,
                                                   clientSecret: self.environment.appID)
        
        
        networkTask.execute(request: loginUserNetworkRequest) { loginUserNetworkResponse in
            
            if let json = loginUserNetworkResponse.response, loginUserNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                let parseTask = JSONParseTask<AuthResponse>()
                
                if let loginResponseObject = parseTask.execute(request: parseRequest){
                    callback(loginResponseObject,nil)
                } else {
                    callback(nil,KWSBaseError.JsonParsingError)
                }
                
                
            } else {
                
                if let errorResponse = loginUserNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    callback(nil, mappedResponse)
                    
                } else {
                    callback(nil, loginUserNetworkResponse.error)
                }
            }
        }
    }
}

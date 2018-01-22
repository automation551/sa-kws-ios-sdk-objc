//
//  LoginProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

public struct LoginProvider: LoginService {
    
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func loginUser(username: String, password: String, callback: @escaping (Login?, Error?) -> ()) {
        
        let loginUserNetworkRequest = LoginRequest(environment: environment,
                                                   username: username,
                                                   password: password,
                                                   clientID: environment.mobileKey,
                                                   clientSecret: environment.appID)
        
        let loginUserNetworkTask = NetworkTask()
        loginUserNetworkTask.execute(request: loginUserNetworkRequest) { loginUserNetworkResponse in
            
            //todo finish this and test it
            if let json = loginUserNetworkResponse.response, loginUserNetworkResponse.error == nil{
                
                let jsonParserRequest = JsonParseRequest.init(withRawData: json)
                
                if loginUserNetworkResponse.success{
                    let parseTask = JSONParseTask<Login>()
                }
                
                
            }
            
            
            callback(nil, nil)
        }
    }
}

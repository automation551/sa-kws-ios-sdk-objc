//
//  LoginProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

@objc public class LoginProvider: NSObject {
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    public func loginUser(username: String, password: String, callback: @escaping (LoginResponse?, Error?) -> ()) {

        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
                                                   username: username,
                                                   password: password,
                                                   clientID: self.environment.mobileKey,
                                                   clientSecret: self.environment.appID)

       
       networkTask.execute(request: loginUserNetworkRequest) { loginUserNetworkResponse in

            if let json = loginUserNetworkResponse.response, loginUserNetworkResponse.error == nil{

                let parseRequest = JsonParseRequest.init(withRawData: json)

                if loginUserNetworkResponse.success{
                    let parseTask = JSONParseTask<LoginResponse>()

                    if let loginResponseObject = parseTask.execute(request: parseRequest){
                        callback(loginResponseObject,nil)
                    }else{
                        callback(nil,KWSBaseError.JsonParsingError)
                    }
                }else{
                    let parseTask = JSONParseTask<ErrorResponse>()
                    
                    if let mappedResponse = parseTask.execute(request: parseRequest) {
                        callback(nil, mappedResponse)
                    } else {
                        callback(nil, KWSBaseError.JsonParsingError)
                    } 
                }

            }else{
                // pass the network error forward through the callback to the user
                callback(nil, loginUserNetworkResponse.error)
                print("request \(loginUserNetworkRequest.environment.domain)\(loginUserNetworkRequest.endpoint), generated error:\(loginUserNetworkResponse.error ?? "unknown error" as! Error)")
            }
        }
    }
}

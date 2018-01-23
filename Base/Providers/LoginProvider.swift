//
//  LoginProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

@objc public class LoginProvider: NSObject {
    
    //var environment: KWSNetworkEnvironment

    
    public init(withName name:String) {
        print(name)
        //self.environment = KWSNetworkEnvironment()
        super.init()
    }
    
    @objc public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        //self.environment = environment
        super.init()
    }
    
//    public func loginUser(username: String, password: String, callback: @escaping (Login?, Error?) -> ()) {
//
//        let loginUserNetworkRequest = LoginRequest(environment: self.environment,
//                                                   username: username,
//                                                   password: password,
//                                                   clientID: self.environment.mobileKey,
//                                                   clientSecret: self.environment.appID)
//
//        let loginUserNetworkTask = NetworkTask()
//        loginUserNetworkTask.execute(request: loginUserNetworkRequest) { loginUserNetworkResponse in
//
//            if let json = loginUserNetworkResponse.response, loginUserNetworkResponse.error == nil{
//
//                let parseRequest = JsonParseRequest.init(withRawData: json)
//
//                if loginUserNetworkResponse.success{
//                    let parseTask = JSONParseTask<Login>()
//
//                    if let loginResponseObject = parseTask.execute(request: parseRequest){
//                        callback(loginResponseObject,nil)
//                    }else{
//                        callback(nil,KWSBaseError.JsonParsingError)
//                    }
//                }
//
//            }else{
//                // pass the network error forward through the completionHandler to the user
//                callback(nil, loginUserNetworkResponse.error)
//                print("request \(loginUserNetworkRequest.environment.domain)\(loginUserNetworkRequest.endpoint), generated error:\(loginUserNetworkResponse.error ?? "unknown error" as! Error)")
//            }
//        }
//    }
}

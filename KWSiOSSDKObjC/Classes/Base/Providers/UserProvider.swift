//
//  UserProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs


public class UserProvider: NSObject, UserServiceProtocol {
  
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func getUser(userId: Int, token: String, completionHandler: @escaping (UserDetailsModelProtocol?, Error?) -> ()) {
        
        let getUserDetailsNetworkRequest = UserDetailsRequest(environment: environment,
                                                              userId: userId,
                                                              token: token)
        
        let parseTask = ParseJsonTask<UserDetails>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: getUserDetailsNetworkRequest)
            .map { (result: Result<String>) -> Result<UserDetails> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
            }
        }
    }
    
    public func updateUser(details: [String:Any], token: String, completionHandler: @escaping (Error?) -> ()) {
        
        if let tokenData = UtilsHelpers.getTokenData(token: token), let userId = tokenData.userId {
            
            let updateUserDetailsNetworkRequest = UpdateUserDetailsRequest(environment: environment,
                                                                           userDetailsMap: details ,
                                                                           userId: userId,
                                                                           token: token)
            
            let networkTask = NetworkTask()
            let future = networkTask.execute(input: updateUserDetailsNetworkRequest)
                
            future.onResult { result in
                
                switch result {
                case .success(_):
                    completionHandler(nil)
                case .error(let error):
                    let mappedError = Provider().mapErrorResponse(error: error)
                    completionHandler(mappedError)
                }
            }
        } else {
            let error = KWSBaseError(message: "Error parsing token!")
            completionHandler(error)
        }
    }
}

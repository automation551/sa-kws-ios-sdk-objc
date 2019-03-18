//
//  User+Service.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAMobileBase

public class UserService: NSObject, UserServiceProtocol {
    
    var environment: ComplianceNetworkEnvironment
    
    public init(environment: ComplianceNetworkEnvironment) {
        self.environment = environment
    }
    
    public func getUser(userId: Int, token: String, completionHandler: @escaping (UserDetailsProtocol?, Error?) -> ()) {
        
        let getUserDetailsNetworkRequest = UserDetailsRequest(environment: environment,
                                                              userId: userId,
                                                              token: token)
        
        let parseTask = ParseJsonTask<UserDetailsModel>()
        let networkTask = NetworkTask()
        
        let future = networkTask
            .execute(input: getUserDetailsNetworkRequest)
            .map { (result: Result<String>) -> Result<UserDetailsModel> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
            }
        }
    }
    
    public func updateUser(details: [String:Any], userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
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
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(mappedError)
            }
        }        
    }
}

//
//  UserProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs


@objc public class UserProvider: NSObject, UserServiceProtocol{
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    public func getUser(userId: Int, token: String, completionHandler: @escaping (UserDetailsModelProtocol?, Error?) -> ()) {
        
        let getUserDetailsNetworkRequest = UserDetailsRequest(environment: environment,
                                                              userId: userId,
                                                              token: token)
        
        let parseTask = ParseJsonTask<UserDetails>()
        networkTask = NetworkTask()
        
        let future = networkTask.execute(input: getUserDetailsNetworkRequest)
            .map { (result: Result<String>) -> Result<UserDetails> in
                return result.then(parseTask.execute)
        }
        
        future.onResult{ (result) in
            
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
    
    public func updateUser(details: UserDetailsModelProtocol, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        //TODO redo this bit
        let tokenData = self.getTheTokenData(token: token)
        
        let userId = tokenData?.userId?.intValue
        
        let updateUserDetailsNetworkRequest = UpdateUserDetailsRequest(environment: environment,
                                                                       userDetails: details as! UserDetails,
                                                                       userId: userId!,
                                                                       token: token)
        
        networkTask = NetworkTask()
        
        let future = networkTask.execute(input: updateUserDetailsNetworkRequest)
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                completionHandler(nil)
                break
            case .error(let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(mappedError)
                
                break
            }
        }
    }
    
    private func getTheTokenData(token : String) -> TokenData?{
        
        //TODO this has to be here?
        
        let base64T = ParseBase64Task()
        let parseTask = ParseJsonTask<TokenData>()
        let resultToken = base64T.execute(input: token).then(parseTask.execute)
        
        switch resultToken {
        case .success(let tokenData):
            return tokenData
            break
        case .error(let error):
            return nil
            break
            
        }
    }
    
    
    //TODO: this will be in another Provider
    public func requestPermissions(userId: Int, token: String, permissionsList: [String], completionHandler: @escaping (Bool, Error?) -> ()) {
        
        let requestPermissionsNetworkRequest = PermissionsRequest(environment: environment,
                                                                  userId: userId,
                                                                  token: token,
                                                                  permissionsList: permissionsList)
        
        //todo redo this
        networkTask = NetworkTask()
        
        let future = networkTask.execute(input: requestPermissionsNetworkRequest)
        
        future.onResult { (result) in
            
            switch result {
            case .success(let mappedResponse):
                completionHandler(true, nil)
                break
            case .error(let error):
                
                let mappedError = ErrorResponse().mapErrorResponse(error: error)
                completionHandler(false, mappedError)
                
                break
            }
            
        }
    }
    
}

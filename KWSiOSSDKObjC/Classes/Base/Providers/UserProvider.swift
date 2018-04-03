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
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    public func getUser(userId: Int, token: String, completionHandler: @escaping (UserDetailsModelProtocol?, Error?) -> ()) {
        
        let getUserDetailsNetworkRequest = UserDetailsRequest(environment: environment,
                                                              userId: userId,
                                                              token: token)
        
        networkTask.execute(request: getUserDetailsNetworkRequest){ getUserDetailsNetworkResponse in
            
            if let json = getUserDetailsNetworkResponse.response, getUserDetailsNetworkResponse.error == nil{
                
                let parseRequest = JsonParseRequest.init(withRawData: json)
                let parseTask = JSONParseTask<UserDetails>()
                
                if let getUserDetailsResponseObject = parseTask.execute(request: parseRequest){
                    completionHandler(getUserDetailsResponseObject, nil)
                } else {
                    completionHandler(nil, KWSBaseError.JsonParsingError)
                }
                
            }else{
                if let errorResponse = getUserDetailsNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(nil, mappedResponse)
                    
                } else {
                    completionHandler(nil, getUserDetailsNetworkResponse.error)
                }
            }
        }
        
    }

    
    public func updateUser(details: UserDetailsModelProtocol, token: String, completionHandler: @escaping (Error?) -> ()) {
        //this is the old version, will be deleted once the Protobufs updates
    }
    
    
    public func updateUser(details: [String:Any], token: String, completionHandler: @escaping (Error?) -> ()) {
        
        //this will be improved
        let userId = self.getTheTokenData(token: token)?.userId?.intValue ?? 0
        
        let updateUserDetailsNetworkRequest = UpdateUserDetailsRequest(environment: environment,
                                                                       userDetailsMap: details ,                                                                    
                                                                       userId: userId,
                                                                       token: token)
        
        networkTask.execute(request: updateUserDetailsNetworkRequest){ updateUserDetailsNetworkResponse in
            
            if (updateUserDetailsNetworkResponse.success && updateUserDetailsNetworkResponse.error == nil) {
                completionHandler( nil)
            } else {
                if let errorResponse = updateUserDetailsNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(mappedResponse)
                    
                } else {
                    completionHandler(updateUserDetailsNetworkResponse.error)
                }
            }
            
        }
    }
    
    public func getTheTokenData (token: String) -> TokenData? {
        
        let base64req = ParseBase64Request(withBase64String: token)
        let base64Task = ParseBase64Task()
        let metadataJson = base64Task.execute(request: base64req)
        
        let parseJsonReq = JsonParseRequest(withRawData: metadataJson!)
        let parseJsonTask = JSONParseTask<TokenData>()
        let metadata = parseJsonTask.execute(request: parseJsonReq)
        
        return metadata
    }
    
    
}

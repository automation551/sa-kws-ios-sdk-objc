//
//  UserActionsProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 03/04/2018.
//

import Foundation
import Foundation
import SAMobileBase
import SAProtobufs


public class UserActionsProvider: NSObject, UserActionsServiceProtocol {
    
    var environment: KWSNetworkEnvironment
    var networkTask: NetworkTask
    
    public init(environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) {
        self.environment = environment
        self.networkTask = networkTask
    }
    
    public func inviteUser(email: String, userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        //TODO
        
    }
    
    public func requestPermissions(permissions: [String], userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        let requestPermissionsNetworkRequest = PermissionsRequest(environment: environment,
                                                                  userId: userId,
                                                                  token: token,
                                                                  permissionsList: permissions)
        
        networkTask.execute(request: requestPermissionsNetworkRequest) { requestPermissionsNetworkResponse in
            
            if (requestPermissionsNetworkResponse.success && requestPermissionsNetworkResponse.error == nil) {
                completionHandler(nil)
            } else {
                if let errorResponse = requestPermissionsNetworkResponse.error?.message {
                    
                    let jsonParseRequest = JsonParseRequest.init(withRawData: (errorResponse))
                    let parseTask = JSONParseTask<ErrorResponse>()
                    let mappedResponse = parseTask.execute(request: jsonParseRequest)
                    completionHandler(mappedResponse)
                    
                } else {
                    completionHandler(requestPermissionsNetworkResponse.error)
                }
            }
            
        }
    }
    
    public func triggerEvent(eventId: String, points: Int, userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        //TODO
        
    }
    
    public func hasTriggeredEvent(eventId: String, userId: Int, token: String, completionHandler: @escaping (HasTriggeredEventModelProtocol?, Error?) -> ()) {
        
        //TODO
        
    }
    
    public func getAppData(userId: Int, appId: Int, token: String, completionHandler: @escaping (AppDataWrapperModelProtocol?, Error?) -> ()) {
        
        //TODO
        
    }
    
    public func setAppData(value: Int, key: String, userId: Int, appId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        //TODO
        
    }    
}

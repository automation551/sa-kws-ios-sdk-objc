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
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func inviteUser(email: String, userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        //TODO
        
    }
    
    public func requestPermissions(permissions: [String], userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        
        let requestPermissionsNetworkRequest = PermissionsRequest(environment: environment,
                                                                  userId: userId,
                                                                  token: token,
                                                                  permissionsList: permissions)
        
        self.parse(request: requestPermissionsNetworkRequest, completionHandler: completionHandler)
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
    
    private func parse(request: BaseRequest,
                       completionHandler: @escaping (Error?) -> ()) {
        
        let networkTask = NetworkTask()
        let future = networkTask.execute(input: request)
        
        future.onResult { networkResponse in
            
            switch networkResponse {
            case .success(_):
                completionHandler(nil)
                break
            case .error(let error):
                let mappedError = Provider().mapErrorResponse(error: error)
                completionHandler(mappedError)
                break
            }
        }
    }
}

//
//  UserActionsService.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 03/04/2018.
//

import Foundation
import SAMobileBase

public class UserActionsService: NSObject, UserActionsServiceProtocol {
    
    var environment: ComplianceNetworkEnvironment
    
    public init(environment: ComplianceNetworkEnvironment) {
        self.environment = environment
    }
    
    public func getAppData(userId: Int, appId: Int, token: String, completionHandler: @escaping (AppDataWrapperModelProtocol?, Error?) -> ()) {
        
        let getAppDataNetworkRequest = GetAppDataRequest.init(environment: environment, appId: appId, userId: userId, token: token)
        
        let networktask = NetworkTask()
        let parseTask = ParseJsonTask<AppDataWrapper>()
        
        let future = networktask
            .execute(input: getAppDataNetworkRequest)
            .map { (result: Result<String>) -> Result <AppDataWrapper> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
                break
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
    
    public func hasTriggeredEvent(eventId: Int, userId: Int, token: String, completionHandler: @escaping (HasTriggeredEventProtocol?, Error?) -> ()) {
        
        let hasTriggeredEventNetworkRequest = HasTriggeredEventRequest.init(environment: environment, eventId: eventId, userId: userId, token: token)
        
        let networktask = NetworkTask()
        let parseTask = ParseJsonTask<HasTriggeredEvent>()
        
        let future = networktask
            .execute(input: hasTriggeredEventNetworkRequest)
            .map { (result: Result<String>) -> Result <HasTriggeredEvent> in
                return result.then(parseTask.execute)
        }
        
        future.onResult { result in
            
            switch result {
            case .success(let value):
                completionHandler(value,nil)
                break
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(nil, mappedError)
                break
            }
        }
    }
    
    public func inviteUser(email: String, userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        let inviteUserNetworkRequest = InviteUserRequest(environment: environment, emailAddress: email, userId: userId, token: token)
        self.parse(request: inviteUserNetworkRequest, completionHandler: completionHandler)
    }
    
    public func requestPermissions(permissions: [String], userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        let requestPermissionsNetworkRequest = PermissionsRequest(environment: environment, userId: userId, token: token,permissionsList: permissions)
        self.parse(request: requestPermissionsNetworkRequest, completionHandler: completionHandler)
    }
    
    public func triggerEvent(eventId: String, points: Int, userId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        let triggerEventNetworkRequest = TriggerEventRequest(environment: environment, eventId: eventId, points: points, userId: userId, token: token)
        self.parse(request: triggerEventNetworkRequest, completionHandler: completionHandler)
    }
    
    public func setAppData(value: Int, key: String, userId: Int, appId: Int, token: String, completionHandler: @escaping (Error?) -> ()) {
        let setAppDataNetworkRequest = SetAppDataRequest(environment: environment, appId: appId, userId: userId, value: value, key: key, token: token)
        self.parse(request: setAppDataNetworkRequest, completionHandler: completionHandler)        
    }
    
    private func parse(request: AbstractRequest,
                       completionHandler: @escaping (Error?) -> ()) {
        
        let networkTask = NetworkTask()
        let future = networkTask.execute(input: request)
        
        future.onResult { networkResponse in
            
            switch networkResponse {
            case .success(_):
                completionHandler(nil)
            case .error(let error):
                let mappedError = AbstractService().mapErrorResponse(error: error)
                completionHandler(mappedError)
            }
        }
    }
}

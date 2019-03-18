//
//  UserActionsService+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol UserActionsServiceProtocol: ServiceProtocol {
    
    func inviteUser(email: String,
                    userId: Int,
                    token: String,
                    completionHandler: @escaping(Error?) -> ())
    
    func requestPermissions(permissions: [String],
                            userId: Int,
                            token: String,
                            completionHandler: @escaping(Error?) -> ())
    
    func triggerEvent(eventId: String,
                      points: Int,
                      userId: Int,
                      token: String,
                      completionHandler: @escaping(Error?) -> ())
    
    func hasTriggeredEvent(eventId: Int,
                           userId: Int,
                           token: String,
                           completionHandler: @escaping(HasTriggeredEventProtocol?, Error?) -> ())
    
    func getAppData(userId: Int,
                    appId: Int,
                    token: String,
                    completionHandler: @escaping(AppDataWrapperModelProtocol?, Error?) -> ())
    
    func setAppData(value: Int,
                    key: String,
                    userId: Int,
                    appId: Int,
                    token: String,
                    completionHandler: @escaping(Error?) -> ())
}

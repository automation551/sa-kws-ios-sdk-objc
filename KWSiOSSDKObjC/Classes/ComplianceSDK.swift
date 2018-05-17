//
//  ComplianceSDK.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class ComplianceSDK : NSObject, AbstractFactoryProtocol {
    
    // MARK: Properties
    
    private let environment: ComplianceNetworkEnvironment!
    
    public init(withEnvironment environment: ComplianceNetworkEnvironment) {
        self.environment = environment
    }
    
    // MARK: Methods
    
    public func getService<T>(withType type: T.Type) -> T? {
        
        if type == AuthServiceProtocol.self {
            return AuthService(environment: environment) as? T
        }
        else if type == UsernameServiceProtocol.self {
            return UsernameService(environment: environment) as? T
        }
        else if type == UserServiceProtocol.self {
            return UserService(environment: environment) as? T
        }
        else if type == UserActionsServiceProtocol.self {
            return UserActionsService(environment: environment) as? T
        }
        else if type == SessionServiceProtocol.self {
            return SessionService(environment: environment) as? T
        }
        else if type == ScoreServiceProtocol.self {
            return ScoreService(environment: environment) as? T
        }
        else if type == SingleSignOnServiceProtocol.self {
            return SingleSignOnService(environment: environment) as? T
        }
        else {
            return nil
        }
    }
}

//
//  KWSSDK.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class KWSSDK : NSObject{
    
    static let _singletonInstance = KWSSDK()
    public override init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    // the sharedInstance class method can be reached from ObjC.
    public class func sharedInstance() -> KWSSDK {
        return KWSSDK._singletonInstance
    }
    
     static public func getService <T> (value: T.Type, environment: KWSNetworkEnvironment) -> T? {
        
        if value == AuthServiceProtocol.self {
            return AuthService(environment: environment) as? T
        }
        else if value == UsernameServiceProtocol.self {
            return UsernameService(environment: environment) as? T
        }
        else if value == UserServiceProtocol.self {
            return UserService(environment: environment) as? T
        }
        else if value == UserActionsServiceProtocol.self {
            return UserActionsService(environment: environment) as? T
        }
        else if value == SessionServiceProtocol.self {
            return SessionService(environment: environment) as? T
        }
        else if value == ScoringServiceProtocol.self {
            return ScoreService(environment: environment) as? T
        }
        else if value == SingleSignOnServiceProtocol.self {
            return SingleSignOnService(environment: environment) as? T
        }
        else {
            return nil
        }
    }
}

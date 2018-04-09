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
            return AuthProvider(environment: environment) as? T
        }
        else if value == UsernameServiceProtocol.self {
            return UsernameProvider(environment: environment) as? T
        }
        else if value == UserServiceProtocol.self {
            return UserProvider(environment: environment) as? T
        }
        else if value == UserActionsServiceProtocol.self {
            return UserActionsProvider(environment: environment) as? T
        }
        else if value == SessionServiceProtocol.self {
            return SessionProvider(environment: environment) as? T
        }
        else {
            return nil
        }
    }
}

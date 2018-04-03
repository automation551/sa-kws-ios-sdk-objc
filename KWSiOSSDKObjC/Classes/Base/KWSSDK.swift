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
    
    
    //for obj c
    public func getProvider (environment: KWSNetworkEnvironment,type: String) -> AnyObject {
        var classFromParams = NSClassFromString(type)
        switch classFromParams {
        case is AuthProvider.Type:
            return AuthProvider(environment: environment)
        case is UsernameProvider.Type:
            return UsernameProvider(environment: environment)
        case is UserProvider.Type:
            return UserProvider(environment: environment)
        //todo other providers
        default:
            return KWSBaseError.ServiceError as AnyObject
        }
    }

    //for swift
     static public func getService <T> (value: T.Type, environment: KWSNetworkEnvironment) -> T? {
        if (value == AuthServiceProtocol.self){
            return AuthProvider(environment: environment) as? T
        } else if (value == UsernameServiceProtocol.self){
            return UsernameProvider(environment: environment) as? T
        } else if (value == UserServiceProtocol.self){
            return UserProvider(environment: environment) as? T
        }else if (value == UserActionsServiceProtocol.self){
            return UserActionsProvider(environment: environment) as? T
        } else {
            return nil
        }
    }
    
}

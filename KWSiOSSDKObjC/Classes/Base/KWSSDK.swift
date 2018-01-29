//
//  KWSSDK.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

@objc public class KWSSDK : NSObject{
    
    static let _singletonInstance = KWSSDK()
    public override init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    // the sharedInstance class method can be reached from ObjC.
    public class func sharedInstance() -> KWSSDK {
        return KWSSDK._singletonInstance
    }
    
    
    // todo generic types are not supported in Obj C
    public func getService <T> (environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask(),type: T.Type) -> Any {
        switch type {
        case is LoginService.Type:
            return LoginProvider(environment: environment)
        default:
            return KWSBaseError.ServiceError
        }
    }
    
    //for the time being solution
    public func getLoginProvider (environment: KWSNetworkEnvironment) -> LoginProvider {
          return LoginProvider(environment: environment)
    }
    
    
}

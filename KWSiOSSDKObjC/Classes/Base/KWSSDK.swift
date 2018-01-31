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
    
    
    public func getProvider (environment: KWSNetworkEnvironment,type: String) -> AnyObject {
        var classFromParams = NSClassFromString(type)
        switch classFromParams {
            case is LoginProvider.Type:
                return LoginProvider(environment: environment)
            //todo other providers
            default:
                return KWSBaseError.ServiceError as AnyObject
        }
    }
    
}

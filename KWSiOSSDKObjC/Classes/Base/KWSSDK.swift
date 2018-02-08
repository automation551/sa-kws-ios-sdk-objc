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
    
    
    //for obj c
    public func getProvider (environment: KWSNetworkEnvironment,type: String) -> AnyObject {
        var classFromParams = NSClassFromString(type)
        switch classFromParams {
        case is LoginProvider.Type:
            return LoginProvider(environment: environment)
        case is CreateUserProvider.Type:
            return CreateUserProvider(environment: environment)
        case is RandomUsernameProvider.Type:
            return RandomUsernameProvider(environment: environment)
        case is UserProvider.Type:
            return UserProvider(environment: environment)
        //todo other providers
        default:
            return KWSBaseError.ServiceError as AnyObject
        }
    }
    
    //for swift
    func getService <T:BaseService> (value: T.Type, environment: KWSNetworkEnvironment) -> T? {
        if (value == LoginService.self) {
            return LoginProvider(environment: environment) as? T
        } else if (value == CreateUserService.self){
            return CreateUserProvider(environment: environment) as? T
        } else if (value == RandomUsernameService.self){
            return RandomUsernameProvider(environment: environment) as? T
        } else if (value == UserService.self){
            return UserProvider(environment: environment) as? T
        } else {
            
            return nil
        }
    }
    
}

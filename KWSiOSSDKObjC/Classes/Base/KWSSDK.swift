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
    
    
    public func getService <T> (environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask(),type: T.Type) -> Any {
        switch type {
        case is LoginService.Type:
            return LoginProvider(environment: environment, networkTask: networkTask)
        default:
            return KWSBaseError.ServiceError
        }
    }
    
    public func getLoginProvider(){
        
    }
    
    public func getLoginProvider (environment: KWSNetworkEnvironment, networkTask: NetworkTask = NetworkTask()) -> LoginProvider {
          return LoginProvider(environment: environment, networkTask: networkTask)
    }
    
    public func testKWSSDK() -> String {
        return "Hello KWSSDK"
    }
    
    
}

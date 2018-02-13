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
    
    public func getKWSMetadata (token: String) -> MetadataKWS? {
        
        let base64req = ParseBase64Request(withBase64String: token)
        let base64Task = ParseBase64Task()
        let metadataJson = base64Task.execute(request: base64req)
        
        let parseJsonReq = JsonParseRequest(withRawData: metadataJson!)
        let parseJsonTask = JSONParseTask<MetadataKWS>()
        let metadata = parseJsonTask.execute(request: parseJsonReq)
        
        return metadata
    }
    
    public func getUserDetailsCountryCode(country: String) -> String?{
        
        /*
         .This is a helper mapping to the `country` from GET User Details, for the PUT in update user.
          - The GET User Details responds with country as full name (e.g "United Kingdom")
          - The PUT Update User Details needs to send a `lowercase country code` (!!!)
         */
        
        switch country {
        case "gb", "GB", "United Kingdom":
            return "gb"
        case "us", "US", "United States":
            return "us"
        case "it", "IT", "Italy":
            return ""
        case "nl", "NL", "Netherlands":
            return ""
        case "fr", "FR", "France":
            return ""
        case "be", "BE", "Belgium":
            return "be"
        default:
            return ""
        }
        
    }
}

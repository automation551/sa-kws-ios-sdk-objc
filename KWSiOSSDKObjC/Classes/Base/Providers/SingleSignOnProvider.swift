//
//  SingleSignOnProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class SingleSignOnProvider: NSObject, SingleSignOnServiceProtocol {
  
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func signOn(url: String, parent: UIViewController, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        let oAuthCodeGenerator = OAuthCodeTask()
        let oAuthDataClass = oAuthCodeGenerator.execute(input: ())
        
        //TODO
        print("OAuth data codeChallenge:\(oAuthDataClass.codeChallenge)\nOAuth data code verifier: \(oAuthDataClass.codeVerifier)\nOAuth data code method: \(oAuthDataClass.codeChallengeMethod)")
        
        
    }
    
}

//
//  OAuthUserTokenRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 15/04/2018.
//

import Foundation
import SAMobileBase

public class OAuthUserTokenRequest: BaseRequest {
    
    public init(environment: KWSNetworkEnvironment,
                clientID: String,
                authCode: String,
                codeVerifier: String,
                clientSecret: String) {
        
        super.init(environment: environment)
        
        self.method = .POST
        self.endpoint = "oauth/token"
        self.formEncodeUrls = true
        self.headers = ["Content-Type": "application/x-www-form-urlencoded"]
        self.body = [
            "grant_type": "authorization_code",
            "client_id": clientID,
            "code": authCode,
            "client_secret": clientSecret,
            "code_verifier": codeVerifier
        ]
    }
}

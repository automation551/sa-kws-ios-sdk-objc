//
//  LoginRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

public class LoginRequest: BaseRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                username: String,
                password: String,
                clientID: String,
                clientSecret: String) {
    
        super.init(environment: environment)
        
        self.method = .POST
        self.endpoint = "oauth/token"
        self.formEncodeUrls = true
        self.headers = ["Content-Type": "application/x-www-form-urlencoded"]
        self.body = [
            "grant_type": "password",
            "username": username,
            "password": password,
            "client_id": clientID,
            "client_secret":  clientSecret
        ]
    }
}


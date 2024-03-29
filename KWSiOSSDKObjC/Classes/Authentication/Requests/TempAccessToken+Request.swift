//
//  TempAccessToken+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase

public class TempAccessTokenRequest: AbstractRequest{
    
    public init(environment: ComplianceNetworkEnvironment,
                clientID: String,
                clientSecret: String) {
        
        super.init(environment: environment)
        
        self.method = .POST
        self.endpoint = "oauth/token"
        self.formEncodeUrls = true
        self.headers = ["Content-Type": "application/x-www-form-urlencoded"]
        self.body = [
            "grant_type": "client_credentials",
            "client_id": clientID,
            "client_secret": clientSecret
        ]        
    }
}

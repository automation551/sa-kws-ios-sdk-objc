//
//  AppConfig+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase

public class AppConfigRequest: AbstractRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                clientID: String) {
        
        super.init(environment: environment)
        
        self.endpoint = "v1/apps/config"        
        self.query = ["oauthClientId": clientID]
    }
}

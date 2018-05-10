//
//  RandomUsername+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAMobileBase

public class RandomUsernameRequest: AbstractRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                appID: Int) {
        
        super.init(environment: environment)
        
        self.endpoint = "v2/apps/\(appID)/random-display-name"        
    }
}

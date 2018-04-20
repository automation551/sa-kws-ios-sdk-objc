//
//  Leaders+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAMobileBase

public class LeadersRequest: BaseRequest{
    
    public init(environment: ComplianceNetworkEnvironment,
                appId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.endpoint = "v1/apps/\(appId)/leaders"
    }
}

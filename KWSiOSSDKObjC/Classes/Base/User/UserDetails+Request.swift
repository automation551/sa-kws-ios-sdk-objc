//
//  UserDetails+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAMobileBase

public class UserDetailsRequest: BaseRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                userId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.endpoint = "v1/users/\(userId)"
    }
}


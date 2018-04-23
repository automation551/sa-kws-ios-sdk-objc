//
//  UpdateUserDetails+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 12/02/2018.
//

import Foundation
import SAMobileBase

public class UpdateUserDetailsRequest: BaseRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                userDetailsMap: [String : Any],
                userId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.method = .PUT
        self.endpoint = "v1/users/\(userId)"
        self.body = userDetailsMap        
    }
}

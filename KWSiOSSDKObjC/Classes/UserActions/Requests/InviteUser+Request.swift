//
//  InviteUser+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//

import Foundation
import SAMobileBase

public class InviteUserRequest: AbstractRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                emailAddress: String,
                userId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.method = .POST
        self.endpoint = "v1/users/\(userId)/invite-user"
        self.body = ["email" : emailAddress]
    }
}

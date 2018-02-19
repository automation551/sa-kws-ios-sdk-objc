//
//  PermissionsRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 19/02/2018.
//

import Foundation
import SAMobileBase

public class PermissionsRequest: BaseRequest {
    
    
    public init(environment: KWSNetworkEnvironment,
                userId: Int,
                token: String,
                permissionsList: [String]) {
        
        super.init(environment: environment, token: token)
        
        self.method = .POST
        self.endpoint = "v1/users/\(userId)/request-permissions"
        self.body = [
            "permissions": permissionsList
        ]
    }
}

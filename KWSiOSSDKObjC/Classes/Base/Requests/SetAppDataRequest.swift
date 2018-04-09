//
//  SetAppDataRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//
import Foundation
import SAMobileBase

public class SetAppDataRequest: BaseRequest {
    
    public init(environment: KWSNetworkEnvironment,
                appId: Int,
                userId: Int,
                value: Int,
                key: String,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.method = .POST
        self.endpoint = "v1/apps/\(appId)/users/\(userId)/app-data/set"
        self.body = [
            "name": key,
            "value": value
        ]
    }
}

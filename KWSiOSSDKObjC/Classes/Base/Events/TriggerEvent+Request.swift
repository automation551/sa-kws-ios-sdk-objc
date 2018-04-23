//
//  TriggerEvent+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//

import Foundation
import SAMobileBase

public class TriggerEventRequest: BaseRequest {
    
    public init(environment: ComplianceNetworkEnvironment,
                eventId: String,
                points: Int,
                userId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.method = .POST
        self.endpoint = "v1/users/\(userId)/trigger-event"
        self.body = [
            "points" : points,
            "token" : eventId
        ]
    }
}

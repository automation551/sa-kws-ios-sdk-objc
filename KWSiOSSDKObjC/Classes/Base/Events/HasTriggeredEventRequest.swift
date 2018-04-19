//
//  HasTriggeredEvent+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//

import Foundation
import SAMobileBase

public class HasTriggeredEventRequest: BaseRequest {
    
    public init(environment: KWSNetworkEnvironment,
                eventId: Int,
                userId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.method = .POST
        self.endpoint = "v1/users/\(userId)/has-triggered-event"
        self.body = ["eventId" : eventId]
    }
}

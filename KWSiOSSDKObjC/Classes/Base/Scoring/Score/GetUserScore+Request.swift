//
//  GetUserScoreRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAMobileBase

public class GetUserScoreRequest: BaseRequest{
    
    public init(environment: KWSNetworkEnvironment,
                appId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.endpoint = "v1/apps/\(appId)/score"
    }
}

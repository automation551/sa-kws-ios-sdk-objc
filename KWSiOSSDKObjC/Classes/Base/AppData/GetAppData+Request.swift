//
//  GetAppData+Request.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation
import SAMobileBase

public class GetAppDataRequest: BaseRequest{
    
    public init(environment: KWSNetworkEnvironment,
                appId: Int,
                userId: Int,
                token: String) {
        
        super.init(environment: environment, token: token)
        
        self.endpoint = "v1/apps/\(appId)/users/\(userId)/app-data"
    }
}

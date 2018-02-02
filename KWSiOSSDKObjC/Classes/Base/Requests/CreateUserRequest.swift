//
//  CreateUserRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import SAMobileBase

public class CreateUserRequest: BaseRequest{
    
    public init(environment: KWSNetworkEnvironment,
                username: String,
                password: String,
                dateOfBirth: String,
                country: String,
                parentEmail: String,
                token: String,
                appID: Int) {
        
        
        super.init(environment: environment, token: token)
        
        self.method = .POST
        self.endpoint = "v1/apps/\(appID)/users"
        self.body = [
            "username": username,
            "password": password,
            "dateOfBirth": dateOfBirth,
            "country": country,
            "parentEmail":  parentEmail,
            "authenticate":  true
        ]
        
        self.query = [
            "access_token": token
        ]
        
        
        
    }
    
    
}


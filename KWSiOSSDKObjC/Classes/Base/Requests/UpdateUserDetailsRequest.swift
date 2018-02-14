//
//  UpdateUserDetails.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 12/02/2018.
//

import Foundation
import SAMobileBase

public class UpdateUserDetailsRequest: BaseRequest {
    
    public init(environment: KWSNetworkEnvironment,
                userDetails: UserDetails,
                userId: Int,
                token: String) {
        
        self.userDetails = userDetails
        
        super.init(environment: environment, token: token)
        
        self.method = .PUT
        self.endpoint = "v1/users/\(userId)"
        self.body = bodyTemp
        
    }
    
    let userDetails: UserDetails
    
    var bodyTemp: [String : Any]?{
        get {
            var tmpBody: [String:Any] = [:]
            
            if let firstName = userDetails.firstName, !firstName.isEmpty {
                tmpBody["firstName"] = firstName
            }
            
            if let lastName = userDetails.lastName, !lastName.isEmpty {
                tmpBody["lastName"] = userDetails.lastName
            }
            
            if let email = userDetails.email, !email.isEmpty {
                tmpBody["email"] = userDetails.email
            }
            
            if let gender = userDetails.gender, !gender.isEmpty {
                tmpBody["gender"] = userDetails.gender
            }
            
            if let language = userDetails.language, !language.isEmpty {
                tmpBody["language"] = userDetails.language
            }
            
            let encoder = JSONEncoder ()            
            if let address = userDetails.address,
                let jsonDataAddress = try? encoder.encode(address),
                let jsonStringAddress = String(data: jsonDataAddress, encoding: .utf8),
                !jsonStringAddress.isEmpty && jsonStringAddress != "{}"  {
                tmpBody["address"] = jsonStringAddress
            }
            
            if let appProfile = userDetails.applicationProfile,
                let jsonDataAppProfile = try? encoder.encode(appProfile),
                let jsonStringAppProfile = String(data: jsonDataAppProfile, encoding: .utf8),
                !jsonStringAppProfile.isEmpty && jsonStringAppProfile != "{}"  {
                tmpBody["applicationProfile"] = jsonStringAppProfile
            }
            
            return tmpBody
        }
    }
    
}

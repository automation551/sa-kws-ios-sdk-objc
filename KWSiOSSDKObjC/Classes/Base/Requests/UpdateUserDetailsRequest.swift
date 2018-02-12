//
//  UpdateUserDetails.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 12/02/2018.
//

import Foundation
import SAMobileBase

public class UpdateUserDetailsRequest: BaseRequest {
    
    let userDetails: UserDetails
    
    public init(environment: KWSNetworkEnvironment,
                userDetails: UserDetails,
                userId: Int,
                token: String) {
        
        self.userDetails = userDetails
        
        super.init(environment: environment, token: token)
        
        self.method = .PUT
        self.endpoint = "v1/users/\(userId)"
        
        //init with empty dictionary
        self.body = [String: Any]()
        
        //validate adding to body
        addBodyUserDetailsFirstName()
        addBodyUserDetailsLastName()
        addBodyUserDetailsDoB()
        addBodyUserDetailsEmail()
        addBodyUserDetailsPhoneNumber()
        addBodyUserDetailsGender()
        addBodyUserDetailsLanguage()
        addBodyUserDetailsAddressJSONString()
        addBodyUserDetailsAppProfileJSONString()
        
    }
    
    private func addBodyUserDetailsFirstName(){
        if (userDetails.firstName != nil && !(userDetails.firstName?.isEmpty)!){
            self.body!["firstName"] = userDetails.firstName
        }
    }
    
    private func addBodyUserDetailsLastName(){
        if (userDetails.lastName != nil && !(userDetails.lastName?.isEmpty)!){
            self.body!["lastName"] = userDetails.lastName
        }
    }
    
    private func addBodyUserDetailsDoB(){
        if (userDetails.dateOfBirth != nil && !(userDetails.dateOfBirth?.isEmpty)!){
            self.body!["dateOfBirth"] = userDetails.dateOfBirth
        }
    }
    
    private func addBodyUserDetailsEmail(){
        if (userDetails.email != nil && !(userDetails.email?.isEmpty)!){
            self.body!["email"] = userDetails.email
        }
    }
    
    private func addBodyUserDetailsPhoneNumber(){
        if (userDetails.phoneNumber != nil && !(userDetails.phoneNumber?.isEmpty)!){
            self.body!["phoneNumber"] = userDetails.phoneNumber
        }
    }
    
    private func addBodyUserDetailsGender(){
        if (userDetails.gender != nil && !(userDetails.gender?.isEmpty)!){
            self.body!["gender"] = userDetails.gender
            
        }
    }
    
    private func addBodyUserDetailsLanguage(){
        if (userDetails.language != nil && !(userDetails.language?.isEmpty)!){
            self.body!["language"] = userDetails.language
        }
    }
    
    private func addBodyUserDetailsAddressJSONString(){
        
        if(userDetails.address != nil){
            
            let encoder = JSONEncoder()
            
            let jsonDataUserDetailsAddress = try? encoder.encode(userDetails.address)
            var userDetailsJSONString = ""
            
            if(jsonDataUserDetailsAddress != nil){
                userDetailsJSONString = String(data: jsonDataUserDetailsAddress!, encoding: .utf8)!
                print("User Details as JSON string -> \n" + userDetailsJSONString + "\n")
            }else{
                print("Couldn't parse the user details address...something went wrong!")
            }
            
            if(!userDetailsJSONString.isEmpty){
                self.body!["address"] = userDetailsJSONString
            }
        }
    }
    
    private func addBodyUserDetailsAppProfileJSONString(){
        
        if(userDetails.applicationProfile != nil){
            
            let encoder = JSONEncoder()
            
            let jsonDataUserDetailsAppProfile = try? encoder.encode(userDetails.applicationProfile)
            var userDetailsAppProfileJSONString = ""
            
            if(jsonDataUserDetailsAppProfile != nil){
                userDetailsAppProfileJSONString = String(data: jsonDataUserDetailsAppProfile!, encoding: .utf8)!
                print("User Details App Profile as JSON string -> \n" + userDetailsAppProfileJSONString + "\n")
            }else{
                print("Couldn't parse the user details address...something went wrong!")
            }
            
            if(!userDetailsAppProfileJSONString.isEmpty){
                self.body!["applicationProfile"] = userDetailsAppProfileJSONString
            }
        }
        
    }
    
}

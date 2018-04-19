//
//  BaseRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

open class BaseRequest: NetworkRequestProtocol {
    
    public init (environment: KWSNetworkEnvironment, token: String? = nil) {
        self.environment = environment
        
        headers = ["Content-Type" : "application/json"]
        
        if let token = token {
            headers?["Authorization"] = "Bearer \(token)"
        }
    }

    open var headers: [String:String]?

    open var query: [String : Any]?
    
    open var method: NetworkMethod = .GET
  
    open var body: [String : Any]? = nil
    
    open var environment: NetworkEnvironmentProtocol
    
    open var endpoint: String = ""
    
    open var formEncodeUrls: Bool = false
}

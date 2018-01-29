//
//  BaseRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

public class BaseRequest: NetworkRequest {
    
    public init (environment: KWSNetworkEnvironment, token: String? = nil) {
        self.environment = environment
        
        headers = ["Content-Type" : "application/json"]
        
        if let token = token {
            headers?["Authorization"] = "Bearer \(token)"
        }
    }

    public var headers: [String:String]?

    public var query: [String : Any]?
    
    public var method: NetworkMethod = .GET
  
    public var body: [String : Any]? = nil
    
    public var environment: NetworkEnvironment
    
    public var endpoint: String = ""
    
    public var formEncodeUrls: Bool = false
}

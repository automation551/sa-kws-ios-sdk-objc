//
//  BaseRequest.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import SAMobileBase

public class BaseRequest: NetworkRequest {
    
    private var token: String?
    
    public init (environment: KWSNetworkEnvironment, token: String? = nil) {
        self.environment = environment
        self.token = token
    }
    
    public var headers: [String:String]? {
        get {
            var defaultHeaders = [
                "Content-Type" : "application/json"
            ]
            
            if let token = token {
                defaultHeaders["Authorization"] = "Bearer \(token)"
            }
            
            return defaultHeaders
        }
        set(header) {
            self.headers = header
        }
    }
    
    public var query: [String : Any]?
    
    public var method: NetworkMethod = .GET
  
    public var body: [String : Any]? = nil
    
    public var environment: NetworkEnvironment
    
    public var endpoint: String = ""
    
    public var formEncodeUrls: Bool = false
    
  

}

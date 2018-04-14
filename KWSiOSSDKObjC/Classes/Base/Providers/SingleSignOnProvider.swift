//
//  SingleSignOnProvider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 14/04/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class SingleSignOnProvider: NSObject, SingleSignOnServiceProtocol {
  
    var environment: KWSNetworkEnvironment
    
    public init(environment: KWSNetworkEnvironment) {
        self.environment = environment
    }
    
    public func signOn(url: String, parent: UIViewController, completionHandler: @escaping (LoggedUserModelProtocol?, Error?) -> ()) {
        
        
        
    }
    
}

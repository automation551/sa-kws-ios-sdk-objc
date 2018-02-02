//
//  MetadataKWS.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 02/02/2018.
//

import Foundation
import UIKit

@objc(MetadataKWS)
public final class MetadataKWS: NSObject {
    
    public let appId: Int?
    public let clientId: String?
    public let scope: String?
    public let iat: Int?
    public let exp: Int?
    public let iss: String?
    
    public required init(appId: Int? = -1,
                         clientId: String? = "",
                         scope: String? = "",
                         iat: Int? = -1,
                         exp: Int? = -1,
                         iss: String? = "") {
        
        self.appId = appId
        self.clientId = clientId
        self.scope = scope
        self.iat = iat
        self.exp = exp
        self.iss = iss
        
        
    }
    
    
    
}

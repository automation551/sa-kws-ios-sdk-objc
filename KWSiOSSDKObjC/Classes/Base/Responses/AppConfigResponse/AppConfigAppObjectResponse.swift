//
//  AppConfigAppObjectResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
@objc(KWSAppConfigAppObjectResponse)
public final class AppConfigAppObjectResponse: NSObject {
    
    public let id: Int?
    public let name: String?
    
    public required init(id: Int?,
                         name: String? = "") {
        
        self.id = id
        self.name = name
        
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AppConfigAppObjectResponse else { return false }
        return self.id == object.id
    }
    
}

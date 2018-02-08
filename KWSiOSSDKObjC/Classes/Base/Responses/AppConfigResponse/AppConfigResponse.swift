//
//  AppConfigResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
@objc(KWSAppConfigResponse)
public final class AppConfigResponse: NSObject {
    
    public let app: AppConfigAppObjectResponse?
    
    public required init(app: AppConfigAppObjectResponse?) {
        
        self.app = app
        
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AppConfigResponse else { return false }
        return self.app == object.app
    }
    
}

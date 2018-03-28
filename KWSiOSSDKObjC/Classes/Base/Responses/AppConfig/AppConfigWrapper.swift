//
//  AppConfigWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAProtobufs

@objc(KWSAppConfigResponse)
public final class AppConfigWrapper: NSObject, AppConfigWrapperModelProtocol {
    
    public var app: AppConfigModelProtocol
    
    public required init(app: AppConfig) {
        
        self.app = app
        
    }

}

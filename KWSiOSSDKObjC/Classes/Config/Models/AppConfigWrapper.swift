//
//  AppConfigWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation

public final class AppConfigWrapper: NSObject, AppConfigWrapperModelProtocol {
    
    public var app: AppConfigModelProtocol
    
    public required init(app: AppConfigModel) {
        self.app = app        
    }
}

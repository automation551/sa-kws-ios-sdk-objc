//
//  AppConfigWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAProtobufs

public final class AppConfigWrapper: NSObject, AppConfigWrapperModelProtocol, Codable {
    
    public var app: AppConfigModelProtocol
    
    public required init(app: AppConfigModel) {
        self.app = app        
    }
    
    enum CodingKeys: String, CodingKey {
        case app
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app = try values.decode(AppConfigModel.self, forKey: .app)
    }
}


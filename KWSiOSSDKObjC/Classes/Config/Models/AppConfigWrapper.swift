//
//  AppConfigWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation

public final class AppConfigWrapper: AppConfigWrapperModelProtocol, Codable {
    
    public var app: AppConfigModelProtocol
    
    public required init(app: AppConfigModel) {
        self.app = app        
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        app = try values.decode(AppConfigModel.self, forKey: .app)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: CodingKeys.self)
        if let app = app as? AppConfigModel {
            try container.encode (app, forKey: .app)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case app
    }
}

//
//  AppConfigAppObjectResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation

public struct AppConfigModel: Equatable, AppConfigModelProtocol, Codable {
    
    public var id: Int
    public var name: String
    
    public init(id: Int,
                name: String) {
        
        self.id = id
        self.name = name        
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

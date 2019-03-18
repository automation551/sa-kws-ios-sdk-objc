//
//  ApplicationProfile.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

public struct ApplicationProfileModel: Equatable, AppProfileModelProtocol, Codable {
    
    public var customField1: Int?
    public var customField2: Int?
    public var avatarId: Int?
    public var name: String?
    
    public init(customField1: Int? = nil,
                customField2: Int? = nil,
                avatarId: Int? = nil,
                name: String?) {
        
        self.customField1 = customField1
        self.customField2 = customField2
        self.avatarId = avatarId
        self.name = name
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        customField1 = try values.decodeIfPresent(Int.self, forKey: .customField1) ?? nil
        customField2 = try values.decodeIfPresent(Int.self, forKey: .customField2) ?? nil
        avatarId = try values.decodeIfPresent(Int.self, forKey: .avatarId) ?? nil
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case customField1
        case customField2
        case avatarId
        case name = "username"
    }
}

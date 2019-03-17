//
//  AppData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation

public final class AppData: AppDataModelProtocol, Codable {
    
    public var value: Int
    public var name: String?
    
    public required init(value: Int,
                         name: String?) {
        
        self.value = value
        self.name = name        
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        value = try values.decode(Int.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case value
        case name
    }
}

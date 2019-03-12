//
//  AppData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation
import SAProtobufs

public final class AppData: NSObject, AppDataModelProtocol, Codable {
    
    public var value:   Int
    public var name:    String?
    
    public required init(value: Int,
                         name:  String?) {
        
        self.value = value
        self.name = name        
    }
    
    // MARK: - Equatable
    public static func ==(lhs: AppData, rhs: AppData) -> Bool {
        let areEqual = lhs.value == rhs.value && lhs.name == rhs.name        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AppData else { return false }
        return self == object
    }
    
    enum CodingKeys: String, CodingKey {
        case value
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decode(Int.self, forKey: .value)
        name = try values.decode(String.self, forKey: .name)
    }
}


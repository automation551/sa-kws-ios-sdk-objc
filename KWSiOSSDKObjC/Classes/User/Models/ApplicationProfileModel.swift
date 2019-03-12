//
//  ApplicationProfile.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class ApplicationProfileModel: NSObject, AppProfileModelProtocol, Codable {
    
    public var customField1:    Int?
    public var customField2:    Int?
    public var avatarId:        Int?
    public var name:            String?
    
    public required init(customField1:  Int? = nil,
                         customField2:  Int? = nil,
                         avatarId:      Int? = nil,
                         name:          String?
                         ) {
        
        self.customField1 = customField1
        self.customField2 = customField2
        self.avatarId = avatarId
        self.name = name
    }

    // MARK: - Equatable
    public static func ==(lhs: ApplicationProfileModel, rhs: ApplicationProfileModel) -> Bool {
        let areEqual = lhs.name == rhs.name && lhs.avatarId == rhs.avatarId
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {        
        guard let object = object as? ApplicationProfileModel else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return name!.hashValue
    }
    
    enum CodingKeys: String, CodingKey {
        case customField1
        case customField2
        case avatarId
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customField1 = try values.decode(Int.self, forKey: .customField1)
        customField2 = try values.decode(Int.self, forKey: .customField2)
        avatarId = try values.decode(Int.self, forKey: .avatarId)
        name = try values.decode(String.self, forKey: .name)
    }
}

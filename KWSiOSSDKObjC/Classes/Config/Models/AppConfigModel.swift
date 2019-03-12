//
//  AppConfigAppObjectResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAProtobufs

public final class AppConfigModel: NSObject, AppConfigModelProtocol, Codable {
    
    public var id:      Int
    public var name:    String
    
    public required init(id:    Int,
                         name:  String) {
        
        self.id = id
        self.name = name        
    }
    
    // MARK: - Equatable
    public static func ==(lhs: AppConfigModel, rhs: AppConfigModel) -> Bool {
        let areEqual = lhs.id == rhs.id        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AppConfigModel else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}

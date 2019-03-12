//
//  RandomUsernameResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAProtobufs

public final class RandomUsernameModel: NSObject, RandomUsernameModelProtocol {
    
    public var randomUsername: String?
    
    public required init(randomUsername: String? = "") {
        self.randomUsername = randomUsername
    }
    
    // MARK: - Equatable
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RandomUsernameModel else { return false }
        return self.randomUsername == object.randomUsername
    }
    
    enum CodingKeys: String, CodingKey {
        case randomUsername
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        randomUsername = try values.decode(String.self, forKey: .randomUsername)
    }
}


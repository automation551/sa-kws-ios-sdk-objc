//
//  RandomUsernameResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAProtobufs

public final class RandomUsername: NSObject, RandomUsernameModelProtocol {
    
    public var randomUsername: String?
    
    public required init(randomUsername: String? = "") {
        self.randomUsername = randomUsername
    }
    
    // MARK: - Equatable
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RandomUsername else { return false }
        return self.randomUsername == object.randomUsername
    }
}

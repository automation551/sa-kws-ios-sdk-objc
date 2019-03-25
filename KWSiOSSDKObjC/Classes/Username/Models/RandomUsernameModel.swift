//
//  RandomUsernameResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation

public final class RandomUsernameModel: NSObject, RandomUsernameProtocol {
    
    public var randomUsername: String?
    
    public required init(randomUsername: String? = "") {
        self.randomUsername = randomUsername
    }
    
    // MARK: - Equatable
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RandomUsernameModel else { return false }
        return self.randomUsername == object.randomUsername
    }
}

public protocol VerifiedUsernameProtocol: ModelProtocol {
    
    var available: Bool { get }
    var allowed: Bool { get }
}

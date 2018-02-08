//
//  RandomUsernameResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
@objc(KWSRandomUsernameResponse)
public final class RandomUsernameResponse: NSObject {
    
    public let randomUsername: String?
    
    public required init(randomUsername: String? = "") {
        
        self.randomUsername = randomUsername
        
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RandomUsernameResponse else { return false }
        return self.randomUsername == object.randomUsername
    }
    
    
}

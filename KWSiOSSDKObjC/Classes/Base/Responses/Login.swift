//
//  Login.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import UIKit

//todo what is this?
@objc(KWSLoginResponse)
public final class Login: NSObject {
    
    public let token: String?
    
    public required init(token: String? = "") {
    
        self.token = token
    
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Login else { return false }
        return self.token == object.token
    }
    
    
}

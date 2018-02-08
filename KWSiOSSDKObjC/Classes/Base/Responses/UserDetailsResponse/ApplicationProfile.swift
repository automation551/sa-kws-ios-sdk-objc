//
//  ApplicationProfile.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import UIKit

@objc(KWSSwiftApplicationProfile)
public final class ApplicationProfile: NSObject {

    public let username: String?
    public let customField1: NSNumber?
    public let customField2: NSNumber?
    public let avatarId: NSNumber?
    
    
    
    public required init(username:      String?,
                         customField1:  NSNumber? = nil ,
                         customField2:  NSNumber? = nil ,
                         avatarId:      NSNumber? = nil ) {
        
        self.username = username
        self.customField1 = customField1
        self.customField2 = customField2
        self.avatarId = avatarId
        
    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? UserDetailsResponse else { return false }
        return self.username == object.username
    }
    
    
}

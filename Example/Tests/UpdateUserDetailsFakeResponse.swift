//
//  UpdateUserDetailsFakeResponse.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit

//FAKE DECODER
public final class UpdateUserDetailsFakeResponse: NSObject, Error {
    
    public let userUpdated: Bool?
    public let emailUpdated: Bool?
    public let permissionsRequested: Bool?
    
    
    // MARK: - Initialization
    
    public required init(userUpdated:    Bool?  = false,
                         emailUpdated:   Bool?  = false,
                         permissionsRequested:   Bool?  = false) {
        self.userUpdated = userUpdated
        self.emailUpdated = emailUpdated
        self.permissionsRequested = permissionsRequested
    }
}

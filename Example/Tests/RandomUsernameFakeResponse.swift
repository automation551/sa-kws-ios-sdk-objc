//
//  RandomUsernameFakeResponse.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit

//FAKE DECODER
public final class RandomUsernameFakeResponse: NSObject, Error {
    
    public let randomUsername: String?
    
    // MARK: - Initialization
    
    public required init(randomUsername: String?  = "") {
        self.randomUsername = randomUsername
    }
}

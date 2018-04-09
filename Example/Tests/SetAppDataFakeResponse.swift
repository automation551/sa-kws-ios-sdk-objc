//
//  SetAppDataFakeResponse.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit

//FAKE DECODER
public final class SetAppDataFakeResponse: NSObject, Error {
    
    public let appSet: Bool?
    
    // MARK: - Initialization    
    public required init(appSet: Bool?  = false) {
        self.appSet = appSet
    }
}

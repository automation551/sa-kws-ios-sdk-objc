//
//  KWSError.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import SAMobileBase

public class KWSBaseError : PrintableErrorProtocol {
    
    public var message: String
    
    public required init(message: String) {
        self.message = message
    }
    
    
}

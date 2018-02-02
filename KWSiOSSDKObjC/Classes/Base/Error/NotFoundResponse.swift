//
//  NotFoundResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 01/02/2018.
//

import Foundation
import UIKit

@objc(KWSNotFoundResponse)
public final class NotFoundResponse: NSObject, Error {
    
    public let code: Int
    public let codeMeaning: String
    
    // MARK: - Initialization
    
    public required init(
        
        code: Int       = 0,
        codeMeaning: String           = ""
        
        ) {
        
        self.code = code
        self.codeMeaning = codeMeaning
        
    }
    
    
    
}

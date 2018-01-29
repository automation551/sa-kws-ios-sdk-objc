//
//  ErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 29/01/2018.
//

import Foundation
import UIKit

@objc(KWSErrorResponse)
public final class ErrorResponse: NSObject, Error {
    
    public let errorCode: String
    public let error: String
    
    // MARK: - Initialization
    
    public required init(
        
        errorCode: String       = "",
        error: String           = ""
        
        ) {
        
        self.errorCode = errorCode
        self.error = error
        
    }
    
    
    
}

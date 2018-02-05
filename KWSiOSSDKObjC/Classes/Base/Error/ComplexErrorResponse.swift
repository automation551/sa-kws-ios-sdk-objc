//
//  ComplexErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import UIKit

@objc(KWSComplexErrorResponse)
public final class ComplexErrorResponse: NSObject, Error {
    
    public let code: Int
    public let codeMeaning: String
    public let errorMessage: String
    public let invalid: InvalidError
    
    // MARK: - Initialization
    
    public required init(
        
        code: Int = -1,
        codeMeaning: String  = "",
        errorMessage: String  = "",
        invalid: InvalidError = InvalidError()
        
        ) {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.errorMessage = errorMessage
        self.invalid = invalid
        
    }
    
}

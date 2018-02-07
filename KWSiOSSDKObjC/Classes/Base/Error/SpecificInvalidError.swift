//
//  SpecificInvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
/**
 
 "code": 7,
 "codeMeaning": "invalidValue",
 "errorMessage": "\"username\" length must be at least 3 characters long"
 */
@objc(KWSSpecificInvalidError)
public final class SpecificInvalidError: NSObject, Error {
    
    public let code: Int
    public let codeMeaning: String
    public let errorMessage: String
    public required init(
        
        code: Int = -1,
        codeMeaning: String  = "",
        errorMessage: String  = ""
        
        ) {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.errorMessage = errorMessage
    }
    
}

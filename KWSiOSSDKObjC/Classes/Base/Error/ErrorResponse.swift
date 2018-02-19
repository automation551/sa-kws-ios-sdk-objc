//
//  ErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import UIKit

@objc(KWSErrorResponse)
public final class ErrorResponse: NSObject, Error {
    
    public let code:            Int?
    public let codeMeaning:     String?
    public let errorMessage:    String?
    public let invalid:         InvalidError?
    public let errorCode:       String?
    public let error:           String?
    
    // MARK: - Initialization
    
    public required init(
        
        code:           Int?            = -1,
        codeMeaning:    String?         = "",
        errorMessage:   String?         = "",
        invalid:        InvalidError?   = InvalidError(),
        errorCode:      String?         = "",
        error:          String?         = ""
        
        ) {
        
        self.code           =   code
        self.codeMeaning    =   codeMeaning
        self.errorMessage   =   errorMessage
        self.invalid        =   invalid
        self.errorCode      =   errorCode
        self.error          =   error
        
    }
    
}

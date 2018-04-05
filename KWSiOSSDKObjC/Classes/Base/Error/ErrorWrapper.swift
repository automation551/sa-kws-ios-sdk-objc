//
//  ErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import UIKit
import SAProtobufs

public final class ErrorWrapper: NSObject, Error, ErrorWrapperModelProtocol {
    
    public var code:        Int?
    public var codeMeaning: String?
    public var invalid:     InvalidTypeErrorWrapperModelProtocol?
    public var errorCode:   String?
    public var error:       String?
    public var message:     String?
    
    // MARK: - Initialization
    public required init(code:           Int? = -1,
                         codeMeaning:    String? = "",
                         invalid:        InvalidTypeError? = InvalidTypeError(),
                         errorCode:      String? = "",
                         error:          String? = "",
                         message:        String? = "") {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.invalid = invalid
        self.errorCode = errorCode
        self.error = error
        self.message = message
    }
}

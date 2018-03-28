//
//  ErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import UIKit
import SAMobileBase

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

extension ErrorResponse {
    
    func mapErrorResponse(error: PrintableErrorProtocol) -> Error {
        let parseTask = ParseJsonTask<ErrorResponse>()
        let error = parseTask.execute(input: error.message)
        
        switch (error) {
        case .success(let serverError):
            return serverError
            break
        case .error(_):
            return error as! Error
            break
        }
    }
}

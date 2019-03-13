//
//  SpecificInvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation

public final class SpecificError: NSObject, Error, ErrorProtocol {
    
    public var code:        Int?
    public var codeMeaning: String?
    public var message:     String?
    
    public required init(code:          Int?,
                        codeMeaning:    String?,
                        message:        String?) {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.message = message
    }    
}

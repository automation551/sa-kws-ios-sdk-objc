//
//  SpecificInvalidErrorResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension SpecificInvalidError: Decodable {
    
    public static func decode(_ json: Any) throws -> SpecificInvalidError {
        
        return try SpecificInvalidError (            
            code:               try json => "code",
            codeMeaning:        try json => "codeMeaning",
            errorMessage:       try json => "errorMessage"
        )
    }
}

//
//  SpecificError+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension SpecificError: Decodable {
    
    public static func decode(_ json: Any) throws -> SpecificError {
        
        return SpecificError (            
            code:               try json => "code",
            codeMeaning:        try json => "codeMeaning",
            message:            try json => "errorMessage"
        )
    }
}

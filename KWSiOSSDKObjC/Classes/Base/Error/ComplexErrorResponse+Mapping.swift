//
//  ComplexErrorResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ComplexErrorResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> ComplexErrorResponse {
        
        return try ComplexErrorResponse (
            code:               try json =>? "code",
            codeMeaning:        try json =>? "codeMeaning",
            errorMessage:       try json =>? "errorMessage",
            invalid:            try json =>? "invalid"
            
        )
    }
}

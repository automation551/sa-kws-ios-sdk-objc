//
//  ErrorResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ErrorResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> ErrorResponse {
        
        return try ErrorResponse (
            code:               try json =>? "code",
            codeMeaning:        try json =>? "codeMeaning",
            errorMessage:       try json =>? "errorMessage",
            invalid:            try json =>? "invalid",
            errorCode:          try json =>? "ErrorCode",
            error:              try json =>? "Error"
            
        )
    }
}

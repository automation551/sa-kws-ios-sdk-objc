//
//  ErrorWrapper+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ErrorWrapper: Decodable {
    
    public static func decode(_ json: Any) throws -> ErrorWrapper {
        
        return try ErrorWrapper (
            code:               try json =>? "code",
            codeMeaning:        try json =>? "codeMeaning",
            invalid:            try json =>? "invalid",
            errorCode:          try json =>? "ErrorCode",
            error:              try json =>? "Error",
            message:            try json =>? "errorMessage"
        )
    }
}

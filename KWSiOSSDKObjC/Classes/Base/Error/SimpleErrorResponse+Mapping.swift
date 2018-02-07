//
//  ErrorResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 29/01/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension SimpleErrorResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> SimpleErrorResponse {
        
        return try SimpleErrorResponse (
            errorCode:  try json => "ErrorCode",
            error:      try json => "Error"
            
        )
    }
}

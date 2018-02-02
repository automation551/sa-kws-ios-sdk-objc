//
//  NotFoundResponse+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 01/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension NotFoundResponse: Decodable {
    
    public static func decode(_ json: Any) throws -> NotFoundResponse {
        
        return try NotFoundResponse (
            code:  try json => "code",
            codeMeaning:      try json => "codeMeaning"
            
        )
    }
}

//
//  HasTriggeredEvent+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension HasTriggeredEvent: Decodable {
    
    public static func decode(_ json: Any) throws -> HasTriggeredEvent {
        
        return try HasTriggeredEvent (
            hasTriggeredEvent:    json => "hasTriggeredEvent"
        )
    }
}

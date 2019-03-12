//
//  HasTriggeredEvent.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//

import Foundation
import SAProtobufs

public final class HasTriggeredEvent: NSObject, HasTriggeredEventModelProtocol, Codable {
    
    public var hasTriggeredEvent: Bool
    
    public required init(hasTriggeredEvent:    Bool) {
        
        self.hasTriggeredEvent = hasTriggeredEvent
    }
    
    enum CodingKeys: String, CodingKey {
        case hasTriggeredEvent
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hasTriggeredEvent = try values.decode(Bool.self, forKey: .hasTriggeredEvent)
    }
}


//
//  HasTriggeredEvent.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//

import Foundation

public final class HasTriggeredEvent: HasTriggeredEventProtocol, Codable {
    
    public var hasTriggeredEvent: Bool
    
    public required init(hasTriggeredEvent: Bool) {
        
        self.hasTriggeredEvent = hasTriggeredEvent
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        hasTriggeredEvent = try values.decode(Bool.self, forKey: .hasTriggeredEvent)
    }
    
    enum CodingKeys: String, CodingKey {
        case hasTriggeredEvent
    }
}

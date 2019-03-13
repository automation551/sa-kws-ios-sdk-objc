//
//  HasTriggeredEvent.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 09/04/2018.
//

import Foundation

public final class HasTriggeredEvent: NSObject, HasTriggeredEventProtocol{
    
    public var hasTriggeredEvent: Bool
    
    public required init(hasTriggeredEvent:    Bool) {
        
        self.hasTriggeredEvent = hasTriggeredEvent
    }
}

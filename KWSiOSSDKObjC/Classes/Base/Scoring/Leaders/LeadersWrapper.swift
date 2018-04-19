//
//  LeadersWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAProtobufs
import KWSiOSSDKObjC

public final class LeadersWrapper: NSObject, LeaderWrapperModelProtocol {
    
    public var results: [LeaderModelProtocol]
    public var count:   Int
    public var offset:  Int
    public var limit:   Int
    
    public required init(results: [LeadersModel],
                         count:   Int,
                         offset:  Int,
                         limit:   Int) {
        
        self.results = results
        self.count = count
        self.offset = offset
        self.limit = limit
    }
}


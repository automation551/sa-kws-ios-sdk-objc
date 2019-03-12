//
//  LeadersWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAProtobufs

public final class LeadersWrapper: NSObject, LeaderWrapperModelProtocol, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case results
        case count
        case offset
        case limit
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([LeadersModel].self, forKey: .results)
        count = try values.decode(Int.self, forKey: .count)
        offset = try values.decode(Int.self, forKey: .offset)
        limit = try values.decode(String.self, forKey: .limit)
    }
}


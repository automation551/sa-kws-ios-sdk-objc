//
//  AppDataWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation

public final class AppDataWrapper: AppDataWrapperModelProtocol, Codable {
    
    public var results: [AppDataModelProtocol]
    public var count: Int
    public var offset: Int
    public var limit: Int
    
    public required init(results: [AppData],
                         count: Int,
                         offset: Int,
                         limit: Int) {
        
        self.results = results
        self.count = count
        self.offset = offset
        self.limit = limit
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        results = try values.decode([AppData].self, forKey: .results)
        count = try values.decode(Int.self, forKey: .count)
        offset = try values.decode(Int.self, forKey: .offset)
        limit = try values.decode(Int.self, forKey: .limit)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container (keyedBy: CodingKeys.self)
        
        if let results = results as? [AppData] {
            try container.encode(results, forKey: .results)
        }
        
        try container.encode(count, forKey: .count)
        try container.encode(offset, forKey: .offset)
        try container.encode(limit, forKey: .limit)
    }
    
    enum CodingKeys: String, CodingKey {
        case results
        case count
        case offset
        case limit
    }
}

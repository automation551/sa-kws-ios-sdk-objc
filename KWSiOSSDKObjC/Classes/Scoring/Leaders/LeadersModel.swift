//
//  LeadersModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation

public struct LeadersModel: Equatable, LeaderProtocol, Codable {
    
    public var score: Int
    public var rank: Int
    public var name: String?
    
    public init(score: Int,
                rank: Int,
                name: String?) {
        
        self.score = score
        self.rank = rank
        self.name = name
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        score = try values.decode(Int.self, forKey: .score)
        rank = try values.decode(Int.self, forKey: .rank)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case score
        case rank
        case name = "user"
    }
}

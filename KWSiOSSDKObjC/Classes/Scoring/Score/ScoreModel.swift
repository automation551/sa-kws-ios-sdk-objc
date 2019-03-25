//
//  ScoreModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation

public struct ScoreModel: Equatable, ScoreProtocol, Codable {
    
    public var score: Int
    public var rank: Int
    
    public init(score: Int,
                rank: Int) {
        
        self.score = score
        self.rank = rank
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        score = try values.decode(Int.self, forKey: .score)
        rank = try values.decode(Int.self, forKey: .rank)
    }
    
    enum CodingKeys: String, CodingKey {
        case score
        case rank
    }
}

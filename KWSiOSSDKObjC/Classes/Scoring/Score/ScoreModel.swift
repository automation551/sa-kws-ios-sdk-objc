//
//  ScoreModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAProtobufs

public final class ScoreModel: NSObject, ScoreModelProtocol, Codable {
    
    public var score:   Int
    public var rank:    Int
    
    public required init(score: Int,
                         rank:  Int) {
        
        self.score = score
        self.rank = rank
    }
    
    // MARK: - Equatable
    public static func ==(lhs: ScoreModel, rhs: ScoreModel) -> Bool {
        let areEqual = lhs.score == rhs.score && lhs.rank == rhs.rank
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ScoreModel else { return false }
        return self == object
    }
    
    enum CodingKeys: String, CodingKey {
        case score
        case rank
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        score = try values.decode(Int.self, forKey: .score)
        rank = try values.decode(Int.self, forKey: .rank)
    }
}


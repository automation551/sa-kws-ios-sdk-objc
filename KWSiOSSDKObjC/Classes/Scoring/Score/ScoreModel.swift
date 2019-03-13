//
//  ScoreModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation

public final class ScoreModel: NSObject, ScoreProtocol {
    
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
}

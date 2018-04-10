//
//  Score.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAProtobufs

public final class Score: NSObject, ScoreModelProtocol {
    
    public var score:   Int
    public var rank:    Int
    
    public required init(score: Int,
                         rank:  Int) {
        
        self.score = score
        self.rank = rank
    }
    
    // MARK: - Equatable
    public static func ==(lhs: Score, rhs: Score) -> Bool {
        let areEqual = lhs.score == rhs.score && lhs.rank == rhs.rank
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Score else { return false }
        return self == object
    }
}

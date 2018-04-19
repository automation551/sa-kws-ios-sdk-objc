//
//  LeadersModel.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import SAProtobufs

public final class LeadersModel: NSObject, LeaderModelProtocol {
    
    public var score:   Int
    public var rank:    Int
    public var name:    String?
    
    public required init(score: Int,
                         rank:  Int,
                         name:  String?) {
        
        self.score = score
        self.rank = rank
        self.name = name
    }
    
    // MARK: - Equatable
    public static func ==(lhs: LeadersModel, rhs: LeadersModel) -> Bool {
        let areEqual = lhs.score == rhs.score && lhs.rank == rhs.rank && lhs.name == rhs.name
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LeadersModel else { return false }
        return self == object
    }
}

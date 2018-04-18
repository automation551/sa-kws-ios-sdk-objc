//
//  Score+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension ScoreModel: Decodable {
    
    public static func decode(_ json: Any) throws -> ScoreModel {
        
        return try ScoreModel (
            score:    json => "score",
            rank:     json => "rank"
        )
    }
}

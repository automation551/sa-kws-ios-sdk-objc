//
//  Score+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension Score: Decodable {
    
    public static func decode(_ json: Any) throws -> Score {
        
        return try Score (
            score:    json => "score",
            rank:     json => "rank"
        )
    }
}

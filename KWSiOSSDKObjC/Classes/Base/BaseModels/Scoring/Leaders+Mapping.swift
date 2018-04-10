//
//  Leaders+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension Leaders: Decodable {
    
    public static func decode(_ json: Any) throws -> Leaders {
        
        return try Leaders (
            score:    json => "score",
            rank:     json => "rank",
            name:     json => "user"
        )
    }
}


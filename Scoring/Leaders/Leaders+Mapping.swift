//
//  Leaders+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension LeadersModel: Decodable {
    
    public static func decode(_ json: Any) throws -> LeadersModel {
        
        return try LeadersModel (
            score:    json => "score",
            rank:     json => "rank",
            name:     json => "user"
        )
    }
}


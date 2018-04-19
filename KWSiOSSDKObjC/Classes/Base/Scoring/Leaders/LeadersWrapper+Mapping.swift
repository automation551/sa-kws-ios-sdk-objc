//
//  LeadersWrapper+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 10/04/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension LeadersWrapper: Decodable {
    
    public static func decode(_ json: Any) throws -> LeadersWrapper {
        
        return try LeadersWrapper (
            results:    json => "results",
            count:      json => "count",
            offset:     json => "offset",
            limit:      json => "limit"
        )
    }
}

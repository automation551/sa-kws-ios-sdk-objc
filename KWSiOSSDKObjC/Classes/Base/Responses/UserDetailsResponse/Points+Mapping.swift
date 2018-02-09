//
//  Points+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension Points: Decodable {
    
    public static func decode(_ json: Any) throws -> Points {
        
        return try Points (
            totalReceived:                      try json =>? "totalReceived" as? NSNumber,
            total:                              try json =>? "total" as? NSNumber,
            totalPointsReceivedInCurrentApp:    try json =>? "totalPointsReceivedInCurrentApp" as? NSNumber,
            availableBalance:                   try json =>? "availableBalance" as? NSNumber,
            pending:                            try json =>? "pending" as? NSNumber
        )
    }
}

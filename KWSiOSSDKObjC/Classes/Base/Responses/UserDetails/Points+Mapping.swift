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


extension Points: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Points.CodingKeys.self)
        
        try container.encode(totalReceived, forKey: .totalReceived)
        try container.encode(total, forKey: .total)
        try container.encode(totalPointsReceivedInCurrentApp, forKey: .totalPointsReceivedInCurrentApp)
        try container.encode(availableBalance, forKey: .availableBalance)
        try container.encode(pending, forKey: .pending)
    }
    
}

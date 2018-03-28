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
            
            pending:    try json =>? "pending" as? NSNumber,
            received:   try json =>? "totalReceived" as? NSNumber,
            total:      try json =>? "total" as? NSNumber,
            balance:    try json =>? "availableBalance" as? NSNumber,
            inApp:      try json =>? "totalPointsReceivedInCurrentApp" as? NSNumber
            
        )
    }
}


extension Points: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Points.CodingKeys.self)
        
        try container.encode(pending, forKey: .pending)
        try container.encode(received, forKey: .received)
        try container.encode(total, forKey: .total)
        try container.encode(balance, forKey: .balance)
        try container.encode(inApp, forKey: .inApp)
    }
    
}

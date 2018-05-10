//
//  Points+Mapping.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension PointsModel: Decodable {
    
    public static func decode(_ json: Any) throws -> PointsModel {
        
        return PointsModel (            
            pending:    try json =>? "pending",
            received:   try json =>? "totalReceived",
            total:      try json =>? "total",
            balance:    try json =>? "availableBalance",
            inApp:      try json =>? "totalPointsReceivedInCurrentApp"
        )
    }
}
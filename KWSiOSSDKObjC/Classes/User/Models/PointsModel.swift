//
//  Points.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

public struct PointsModel: Equatable, PointsProtocols, Codable {
    
    public var pending: Int?
    public var received: Int?
    public var total: Int?
    public var balance: Int?
    public var inApp: Int?

    public init(pending: Int?,
                received: Int?,
                total: Int?,
                balance: Int?,
                inApp: Int?) {
        
        self.pending = pending
        self.received = received
        self.total = total
        self.balance = balance
        self.inApp = inApp
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        pending = try values.decodeIfPresent(Int.self, forKey: .pending) ?? nil
        received = try values.decodeIfPresent(Int.self, forKey: .received) ?? nil
        total = try values.decodeIfPresent(Int.self, forKey: .total) ?? nil
        balance = try values.decodeIfPresent(Int.self, forKey: .balance) ?? nil
        inApp = try values.decodeIfPresent(Int.self, forKey: .inApp) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case pending
        case received = "totalReceived"
        case total
        case balance = "availableBalance"
        case inApp = "totalPointsReceivedInCurrentApp"
    }
}

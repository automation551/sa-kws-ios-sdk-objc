//
//  Score+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol LeaderProtocol: ScoreProtocol, UniqueNameTraitProtocol {}

public protocol HasTriggeredEventProtocol: ModelProtocol {
    
    var hasTriggeredEvent: Bool { get }
}

public protocol LeaderWrapperProtocol: ModelProtocol, ListTraitProtocol {
    
    var results: [LeadersModel] { get }
}

public protocol PointsProtocols: ModelProtocol {
    
    var pending: Int? { get }
    var received: Int? { get }
    var total: Int? { get }
    var balance: Int? { get }
    var inApp: Int? { get }
}

public protocol ScoreProtocol: ModelProtocol {
    
    var score: Int { get }
    var rank: Int { get }
}

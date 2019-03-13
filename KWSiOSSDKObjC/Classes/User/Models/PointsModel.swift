//
//  Points.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation

public final class PointsModel: NSObject, PointsProtocols {
    
    public var pending:         Int?
    public var received:        Int?
    public var total:           Int?
    public var balance:         Int?
    public var inApp:           Int?

    public required init(pending:   Int? = nil,
                         received:  Int? = nil,
                         total:     Int? = nil,
                         balance:   Int? = nil,
                         inApp:     Int? = nil) {

        self.pending = pending
        self.received = received
        self.total = total
        self.balance = balance
        self.inApp = inApp
    }
    
    // MARK: - Equatable
    public static func ==(lhs: PointsModel, rhs: PointsModel) -> Bool {
        let areEqual = lhs.pending == rhs.pending
        && lhs.received == rhs.received
        && lhs.total == rhs.total
        && lhs.balance == rhs.balance
        && lhs.inApp == rhs.inApp
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? PointsModel else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return inApp!.hashValue
    }
}

//
//  Points.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

public final class PointsModel: NSObject, PointsModelProtocols, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case pending
        case received
        case total
        case balance
        case inApp
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pending = try values.decode(Int.self, forKey: .pending)
        received = try values.decode(Int.self, forKey: .received)
        total = try values.decode(Int.self, forKey: .total)
        balance = try values.decode(Int.self, forKey: .balance)
        inApp = try values.decode(Int.self, forKey: .inApp)
    }
}

//
//  Points.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import SAProtobufs

@objc(KWSSwiftPoints)
public final class Points: NSObject, PointsModelProtocols {
    
    public var pending:         Int?
    public var received:        Int?
    public var total:           Int?
    public var balance:         Int?
    public var inApp:           Int?

    public required init(pending:   NSNumber? = nil,
                         received:  NSNumber? = nil,
                         total:     NSNumber? = nil,
                         balance:   NSNumber? = nil,
                         inApp:     NSNumber? = nil) {

        self.pending = pending?.intValue
        self.received = received?.intValue
        self.total = total?.intValue
        self.balance = balance?.intValue
        self.inApp = inApp?.intValue

    }
    
    public enum CodingKeys: String, CodingKey {
        
        //to encode
        case pending
        case received
        case total
        case balance
        case inApp
    }
    
    // MARK: - Equatable
    public static func ==(lhs: Points, rhs: Points) -> Bool {
        let areEqual = lhs.inApp == rhs.inApp
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Points else { return false }
        return self.inApp == object.inApp
    }
    
    public override var hash: Int {
        return inApp!.hashValue
    }
}

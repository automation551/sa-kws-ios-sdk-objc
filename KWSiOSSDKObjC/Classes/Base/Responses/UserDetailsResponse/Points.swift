//
//  Points.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/02/2018.
//

import Foundation
import UIKit

@objc(KWSSwiftPoints)
public final class Points: NSObject {
    
    public let totalReceived:                       NSNumber?
    public let total:                               NSNumber?
    public let totalPointsReceivedInCurrentApp:     NSNumber?
    public let availableBalance:                    NSNumber?
    public let pending:                             NSNumber?
    

    public required init(totalReceived:                     NSNumber? = nil,
                         total:                             NSNumber? = nil,
                         totalPointsReceivedInCurrentApp:   NSNumber? = nil,
                         availableBalance:                  NSNumber? = nil,
                         pending:                           NSNumber? = nil) {

        self.totalReceived = totalReceived
        self.total = total
        self.totalPointsReceivedInCurrentApp = totalPointsReceivedInCurrentApp
        self.availableBalance = availableBalance
        self.pending = pending

    }
    
    // MARK: - Equatable
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Points else { return false }
        return self.totalReceived == object.totalReceived
    }
}

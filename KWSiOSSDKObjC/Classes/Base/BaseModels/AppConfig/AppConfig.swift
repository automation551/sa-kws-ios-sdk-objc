//
//  AppConfigAppObjectResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 07/02/2018.
//

import Foundation
import SAProtobufs

public final class AppConfig: NSObject, AppConfigModelProtocol {
    
    public var id:      Int
    public var name:    String
    
    public required init(id:    Int,
                         name:  String) {
        
        self.id = id
        self.name = name        
    }
    
    // MARK: - Equatable
    public static func ==(lhs: AppConfig, rhs: AppConfig) -> Bool {
        let areEqual = lhs.id == rhs.id
        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AppConfig else { return false }
        return self == object
    }
    
    public override var hash: Int {
        return id.hashValue
    }
}

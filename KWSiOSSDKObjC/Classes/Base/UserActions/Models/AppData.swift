//
//  AppData.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation
import SAProtobufs

public final class AppData: NSObject, AppDataModelProtocol {
    
    public var value:   Int
    public var name:    String?
    
    public required init(value: Int,
                         name:  String?) {
        
        self.value = value
        self.name = name        
    }
    
    // MARK: - Equatable
    public static func ==(lhs: AppData, rhs: AppData) -> Bool {
        let areEqual = lhs.value == rhs.value && lhs.name == rhs.name        
        return areEqual
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AppData else { return false }
        return self == object
    }
}

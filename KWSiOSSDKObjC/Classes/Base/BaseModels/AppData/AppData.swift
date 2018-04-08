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
}

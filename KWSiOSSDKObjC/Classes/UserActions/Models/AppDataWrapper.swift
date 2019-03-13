//
//  AppDataWrapper.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 08/04/2018.
//

import Foundation

public final class AppDataWrapper: NSObject, AppDataWrapperModelProtocol {
    
    public var results:     [AppDataModelProtocol]
    public var count:       Int
    public var offset:      Int
    public var limit:       Int
    
    public required init(results:   [AppData],
                         count:     Int,
                         offset:    Int,
                         limit:     Int) {
        
        self.results = results
        self.count = count
        self.offset = offset
        self.limit = limit
    }
}

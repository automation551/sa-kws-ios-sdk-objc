//
//  SetAppDataFakeResponse+Mapping.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import Decodable
import protocol Decodable.Decodable

extension SetAppDataFakeResponseModel: Decodable {
    
    public static func decode(_ json: Any) throws -> SetAppDataFakeResponseModel {
        
        return try SetAppDataFakeResponseModel (
            appSet:               try json =>? "appSet"
        )
    }
}

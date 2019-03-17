//
//  SetAppDataFakeResponseModel.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 09/04/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit

//FAKE DECODER
public final class SetAppDataFakeResponseModel: NSObject, Error, Codable {
    
    public let appSet: Bool?
    
    // MARK: - Initialization    
    public required init(appSet: Bool?  = false) {
        self.appSet = appSet
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        appSet = try values.decodeIfPresent(Bool.self, forKey: .appSet) ?? false

    }
    
    enum CodingKeys: String, CodingKey {
        case appSet
    }
}

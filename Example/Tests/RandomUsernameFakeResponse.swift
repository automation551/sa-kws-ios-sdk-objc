//
//  RandomUsernameFakeResponse.swift
//  KWSiOSSDKObjC_Tests
//
//  Created by Guilherme Mota on 08/02/2018.
//  Copyright © 2018 Gabriel Coman. All rights reserved.
//

import Foundation
import UIKit

//FAKE DECODER
public final class RandomUsernameFakeResponse: Error, Codable {
    
    public let randomUsername: String?
    
    // MARK: - Initialization
    
    public required init(randomUsername: String?  = "") {
        self.randomUsername = randomUsername
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        randomUsername = try values.decode(String.self, forKey: .randomUsername)
    }
    
    enum CodingKeys: String, CodingKey {
        case randomUsername
    }
}

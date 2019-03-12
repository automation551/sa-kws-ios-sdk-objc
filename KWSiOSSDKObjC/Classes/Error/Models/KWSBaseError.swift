//
//  KWSError.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 23/01/2018.
//

import Foundation
import SAMobileBase

public class KWSBaseError : PrintableErrorProtocol, Codable {
    
    public var message: String
    
    public required init(message: String) {
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decode(String.self, forKey: .message)
    }
}


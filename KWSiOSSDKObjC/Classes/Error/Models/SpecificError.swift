//
//  SpecificInvalidErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import SAProtobufs

public final class SpecificError: NSObject, Error, ErrorModelProtocol, Codable {
    
    public var code:        Int?
    public var codeMeaning: String?
    public var message:     String?
    
    public required init(code:          Int?,
                        codeMeaning:    String?,
                        message:        String?) {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case codeMeaning
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(Int.self, forKey: .code)
        codeMeaning = try values.decode(String.self, forKey: .codeMeaning)
        message = try values.decode(String.self, forKey: .message)
    }
}


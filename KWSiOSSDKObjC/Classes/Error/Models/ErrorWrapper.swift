//
//  ErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import UIKit

public final class ErrorWrapper: Error, ErrorWrapperProtocol, Codable {
    
    public var code: Int?
    public var codeMeaning: String?
    public var invalid: InvalidTypeErrorWrapperProtocol?
    public var errorCode: String?
    public var error: String?
    public var message: String?
    
    // MARK: - Initialization
    public required init(code: Int? = -1,
                         codeMeaning: String? = "",
                         invalid: InvalidTypeError? = InvalidTypeError(),
                         errorCode: String?,
                         error: String? = "",
                         message: String? = "") {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.invalid = invalid
        self.errorCode = errorCode
        self.error = error
        self.message = message
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try values.decodeIfPresent(Int.self, forKey: .code) ?? -1
        codeMeaning = try values.decodeIfPresent(String.self, forKey: .codeMeaning) ?? ""
        invalid = try values.decodeIfPresent(InvalidTypeError.self, forKey: .invalid) ?? InvalidTypeError()
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        error = try values.decodeIfPresent(String.self, forKey: .error) ?? ""
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case codeMeaning
        case invalid
        case errorCode = "ErrorCode"
        case error = "Error"
        case message = "errorMessage"
    }
}

extension ErrorWrapper {
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container (keyedBy: CodingKeys.self)
        
        try container.encode(code, forKey: .code)
        try container.encode(codeMeaning, forKey: .codeMeaning)
        
        if let invalid = invalid as? InvalidTypeError {
            try container.encode(invalid, forKey: .invalid)
        }
        try container.encode(errorCode, forKey: .errorCode)
        try container.encode(error, forKey: .error)
        try container.encode(message, forKey: .message)
    }
}

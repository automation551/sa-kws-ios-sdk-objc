//
//  ErrorResponse.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/02/2018.
//

import Foundation
import UIKit
import SAProtobufs

public final class ErrorWrapper: NSObject, Error, ErrorWrapperModelProtocol, Codable {
    
    public var code:        Int?
    public var codeMeaning: String?
    public var invalid:     InvalidTypeErrorWrapperModelProtocol?
    public var errorCode:   String?
    public var error:       String?
    public var message:     String?
    
    // MARK: - Initialization
    public required init(code:           Int? = -1,
                         codeMeaning:    String? = "",
                         invalid:        InvalidTypeError? = InvalidTypeError(),
                         errorCode:      String? = "",
                         error:          String? = "",
                         message:        String? = "") {
        
        self.code = code
        self.codeMeaning = codeMeaning
        self.invalid = invalid
        self.errorCode = errorCode
        self.error = error
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case codeMeaning
        case invalid
        case errorCode
        case error
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(Int.self, forKey: .code)
        codeMeaning = try values.decode(String.self, forKey: .codeMeaning)
        invalid = try values.decode(InvalidTypeError.self, forKey: .invalid)
        errorCode = try values.decode(String.self, forKey: .errorCode)
        error = try values.decode(String.self, forKey: .error)
        message = try values.decode(String.self, forKey: .message)
    }
}

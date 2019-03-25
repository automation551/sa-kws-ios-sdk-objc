//
//  Abstract+Service.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/04/2018.
//

import Foundation
import SAMobileBase

public class AbstractService: NSObject, ServiceProtocol {

    func mapErrorResponse(error: Error) -> Error {
        let parseTask = ParseJsonTask<ErrorWrapper>()
        let message: String
        if let error = error as? PrintableErrorProtocol {
            message = error.message
        } else {
            message = ""
        }
        let parsedError = parseTask.execute(input: message)
        
        switch (parsedError) {
        case .success(let serverError):
            return serverError
        case .error(_):
            return error
        }
    }
}

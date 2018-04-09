//
//  Provider.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 05/04/2018.
//

import Foundation
import SAMobileBase
import SAProtobufs

public class Provider: NSObject, ServiceProtocol {

    func mapErrorResponse(error: PrintableErrorProtocol) -> Error {
        let parseTask = ParseJsonTask<ErrorWrapper>()
        let parsedError = parseTask.execute(input: error.message)
        
        switch (parsedError) {
        case .success(let serverError):
            return serverError
        case .error(_):
            return error
        }
    }
}

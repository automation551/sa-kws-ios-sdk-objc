//
//  Username+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol RandomUsernameProtocol: ModelProtocol {
    
    var randomUsername: String? { get }
}

public protocol UsernameServiceProtocol: ServiceProtocol {
    
    func getRandomUsername(completionHandler: @escaping(RandomUsernameProtocol?, Error?) -> ())
    
    func verifiyUsername(username: String,
                         completionHandler: @escaping(VerifiedUsernameProtocol?, Error?) -> ())
}

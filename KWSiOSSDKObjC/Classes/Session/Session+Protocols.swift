//
//  Session+Protocols.swift
//  KWSiOSSDKObjC
//
//  Created by Tiziano Bruni on 13/03/2019.
//

import Foundation

public protocol SessionServiceProtocol: ServiceProtocol {
    
    func isUserLoggedIn() -> Bool
    func getLoggedUser() -> LoggedUserProtocol?
    func saveLoggedUser(user: LoggedUserProtocol) -> Bool
    func clearLoggedUser() -> Bool
}

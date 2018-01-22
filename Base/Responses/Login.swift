//
//  Login.swift
//  KWSiOSSDKObjC
//
//  Created by Guilherme Mota on 22/01/2018.
//

import Foundation
import UIKit
import Decodable

//todo what is this?
@objc(KWSLoginResponse)
public final class Login: NSObject {
    
    public let token: String?
    
    public required init(token: String? = "") {
    
        self.token = token
    
    }
    
    
}
